resource "cloudflare_record" "test1" {
  domain = "${var.cloudflare_domain}"
  name   = "demo"
  value  = "${digitalocean_droplet.dockerhost.ipv4_address}"
  type   = "A"
  ttl    = 1
}

resource "cloudflare_record" "docker" {
  domain = "${var.cloudflare_domain}"
  name   = "docker"
  value  = "${digitalocean_droplet.dockerhost.ipv4_address}"
  type   = "A"
  ttl    = 1
}
