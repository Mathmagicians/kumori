SSH_FINGER = $(shell ssh-keygen -E md5 -lf $$HOME/.ssh/id_rsa.pub | awk '{print $$2}' | sed "s/MD5://")

.PHONY: t_init t_plan t_apply t_destroy

tls_setup:
	@./tls_setup.sh

bootstrap: bootstrap-postgres bootstrap-grafana

bootstrap-grafana:
	cd ./grafana && ./bootstrap-grafana.sh

bootstrap-postgres:
	cd ./postgres && make -f Makefile setup

bootstrap-sonarqube:
	cd ./sonarqube && ./bootstrap-sonarqube.sh


build_haproxy:
	./compose.sh -f ./haproxy/docker-compose.yml build

start_haproxy:
	./compose.sh -f ./haproxy/docker-compose.yml up -d

stop_haproxy:
	./compose.sh -f ./haproxy/docker-compose.yml down

t_init:
	@/opt/terraform/terraform init \
  -var "do_token=${DO_PAT}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"

t_plan:
	@/opt/terraform/terraform plan \
  -var "do_token=${DO_PAT}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"

t_apply:
	@/opt/terraform/terraform apply \
  -var "do_token=${DO_PAT}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"

t_destroy:
	@/opt/terraform/terraform destroy \
  -var "do_token=${DO_PAT}" \
  -var "cloudflare_email=${CF_EMAIL}" \
  -var "cloudflare_token=${CF_TOKEN}" \
  -var "cloudflare_domain=${CF_DOMAIN}" \
  -var "pub_key=${HOME}/.ssh/id_rsa.pub" \
  -var "pvt_key=${HOME}/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGER}"
