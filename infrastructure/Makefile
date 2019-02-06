SSH_FINGER = $(shell ssh-keygen -E md5 -lf $$HOME/.ssh/id_rsa.pub | awk '{print $$2}' | sed "s/MD5://")
POSTGRES_PASSWORD = $(shell cat .env | grep 'POSTGRES_PASSWORD' | awk -F "=" '{print $$2}')
POSTGREST_CONNECTION_DB = $(shell cat .env | grep 'POSTGREST_CONNECTION_DB' | awk -F "=" '{print $$2}')

.PHONY: t_init t_plan t_apply t_destroy kumori_start kumori_syop kumori_pull kumori_fixture

tls_setup:
	@./tls_setup.sh

kumori_start:
	@./compose.sh -f ../kumori.yml up -d

kumori_stop:
	@./compose.sh -f ../kumori.yml down

kumori_pull:
	@./compose.sh -f ../kumori.yml pull

kumori_fixture:
	@./docker.sh stop kumori-postgrest
	@./docker.sh exec -i -u postgres kumori-postgres psql -U "${POSTGRES_PASSWORD}" "${POSTGREST_CONNECTION_DB}" < dump.pgsql
	@./docker.sh start kumori-postgrest

kumori_dump:
	@./docker.sh stop kumori-postgrest
	@./docker.sh exec -u postgres kumori-postgres pg_dump --data-only -U "${POSTGRES_PASSWORD}" "${POSTGREST_CONNECTION_DB}" > dump.pgsql
	@./docker.sh start kumori-postgrest

t_init:
	@/opt/terraform/terraform init \
  -var "do_token=${DO_PAT}" \
	-var "kumori_volume=${KUMORI_VOLUME_ID}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"

t_plan:
	@/opt/terraform/terraform plan \
  -var "do_token=${DO_PAT}" \
	-var "kumori_volume=${KUMORI_VOLUME_ID}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"

t_apply:
	@/opt/terraform/terraform apply \
  -var "do_token=${DO_PAT}" \
	-var "kumori_volume=${KUMORI_VOLUME_ID}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"

t_destroy:
	@/opt/terraform/terraform destroy \
  -var "do_token=${DO_PAT}" \
	-var "kumori_volume=${KUMORI_VOLUME_ID}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"
