#!/usr/bin/env bash

TLS_PATH='/home/core/dockertls'

# Enable Docker
systemctl enable docker

# Enable TLS
sed -i "s|--host=fd://|& --tlsverify \
                         --tlscacert=${TLS_PATH}/myca.pem \
                         --tlscert=${TLS_PATH}/final-server-cert.pem \
                         --tlskey=${TLS_PATH}/docker-1-key.pem \
                         -H=0.0.0.0:2376|" /run/systemd/system/docker.service

# Restart Docker
systemctl daemon-reload
docker
