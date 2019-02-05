resource "cloudflare_record" "demo" {
  domain = "${var.cloudflare_domain}"
  name   = "demo"
  value  = "${digitalocean_droplet.dockerhost.ipv4_address}"
  type   = "A"
  ttl    = 1
}

resource "cloudflare_record" "app" {
  domain = "${var.cloudflare_domain}"
  name   = "app"
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
