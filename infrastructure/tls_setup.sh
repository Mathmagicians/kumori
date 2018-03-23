#!/usr/bin/env bash

TLS_PATH="$(pwd)/tls"
CN='docker.yggoo.dk'

# Cleanup
files=( client-key.pem client.cnf client.pem docker-1-key.pem docker.csr \
        docker-client.csr final-server-cert.pem myca.srl myca.pem private-key.pem )
for i in "${files[@]}"; do if [ -f ${TLS_PATH}/${i} ]; then rm "${TLS_PATH}/${i}"; fi; done

# Server
openssl genrsa -aes256 -out ${TLS_PATH}/private-key.pem 4096

openssl req -new -x509 -sha512 -days 365 \
  -subj "/C=DK/ST=DK/L=Copenhagen/O=Main/CN=${CN}" \
  -key ${TLS_PATH}/private-key.pem -out ${TLS_PATH}/myca.pem

openssl genrsa -out ${TLS_PATH}/docker-1-key.pem 4096

openssl req -subj "/CN=${CN}" -sha512 -new \
  -key ${TLS_PATH}/docker-1-key.pem -out ${TLS_PATH}/docker.csr

openssl x509 -req -days 365 -sha256 -in ${TLS_PATH}/docker.csr \
  -CA ${TLS_PATH}/myca.pem -CAkey ${TLS_PATH}/private-key.pem \
  -CAcreateserial -out ${TLS_PATH}/final-server-cert.pem

# Client
openssl genrsa -out ${TLS_PATH}/client-key.pem 4096

openssl req -subj '/CN=client' -new \
  -key ${TLS_PATH}/client-key.pem \
  -out ${TLS_PATH}/docker-client.csr

echo extendedKeyUsage = clientAuth > ${TLS_PATH}/client.cnf

openssl x509 -req -days 365 -sha512 \
  -in ${TLS_PATH}/docker-client.csr \
  -CA ${TLS_PATH}/myca.pem \
  -CAkey ${TLS_PATH}/private-key.pem \
  -CAcreateserial \
  -out ${TLS_PATH}/client.pem \
  -extfile ${TLS_PATH}/client.cnf

cat <<EOF > ./compose.sh
#!/usr/bin/env bash
docker-compose \
--tlsverify \
--tlscacert=$(pwd)/tls/myca.pem \
--tlscert=$(pwd)/tls/client.pem \
--tlskey=$(pwd)/tls/client-key.pem -H=docker.yggoo.dk:2376 \${@}
EOF
chmod 755 ./compose.sh

cat <<EOF > ./docker.sh
#!/usr/bin/env bash
docker \
--tlsverify \
--tlscacert=$(pwd)/tls/myca.pem \
--tlscert=$(pwd)/tls/client.pem \
--tlskey=$(pwd)/tls/client-key.pem -H=docker.yggoo.dk:2376 \${@}
EOF
chmod 755 ./docker.sh
