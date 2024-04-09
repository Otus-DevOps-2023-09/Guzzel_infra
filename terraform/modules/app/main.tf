terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
#    subnet_id = yandex_vpc_subnet.app-subnet.id
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

#resource "yandex_vpc_security_group" "test-sg" {
#  name        = "My security group"
#  description = "description for my security group"
#  network_id  = yandex_vpc_network.test-vpc.id

#  labels = {
#    my-label = "my-label-value"
#  }

#  dynamic "ingress" {
#    for_each = ["80", "8080"]
#    content {
#      protocol       = "TCP"
#      description    = "rule1 description"
#      v4_cidr_blocks = ["0.0.0.0/0"]
#      from_port      = ingress.value
#      to_port        = ingress.value
#    }
#  }

#  egress {
#    protocol       = "ANY"
#    description    = "rule2 description"
#    v4_cidr_blocks = ["0.0.0.0/0"]
#    from_port      = 0
#    to_port        = 65535
#  }
#}
