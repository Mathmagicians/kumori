resource "digitalocean_droplet" "dockerhost" {
  image              = "coreos-stable"
  name               = "coreos"
  region             = "fra1"
  size               = "1gb"
  private_networking = true
  volume_ids         = ["${var.kumori_volume}"]

  ssh_keys = [
    "${var.ssh_fingerprint}",
  ]

  connection {
    user        = "core"
    type        = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/core/dockertls"
    ]
  }

  provisioner "file" {
    source      = "./tls/myca.pem"
    destination = "/home/core/dockertls/myca.pem"
  }

  provisioner "file" {
    source      = "./tls/final-server-cert.pem"
    destination = "/home/core/dockertls/final-server-cert.pem"
  }

  provisioner "file" {
    source      = "./tls/docker-1-key.pem"
    destination = "/home/core/dockertls/docker-1-key.pem"
  }

  provisioner "file" {
    source      = "./tls/tls_setup.sh"
    destination = "/home/core/dockertls/tls_setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 755 /home/core/dockertls/tls_setup.sh",
      "sudo /home/core/dockertls/tls_setup.sh",
    ]
  }
}
