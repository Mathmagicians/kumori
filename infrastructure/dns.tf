resource "cloudflare_record" "test1" {
  domain = "${var.cloudflare_domain}"
  name   = "test1"
  value  = "${digitalocean_droplet.kumori.ipv4_address}"
  type   = "A"
  ttl    = 1
}

resource "cloudflare_record" "test2" {
  domain = "${var.cloudflare_domain}"
  name   = "test2"
  value  = "${digitalocean_droplet.kumori.ipv4_address}"
  type   = "A"
  ttl    = 1
}

resource "cloudflare_record" "docker" {
  domain = "${var.cloudflare_domain}"
  name   = "docker"
  value  = "${digitalocean_droplet.kumori.ipv4_address}"
  type   = "A"
  ttl    = 1
}
