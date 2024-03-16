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



#  connection {
#    type  = "ssh"
#    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
#    user  = "ubuntu"
#    agent = false
#    private_key = file("/home/guzel/.ssh/ubuntu")
# }

#  provisioner "file" {
#    source      = "files/puma.service"
#    destination = "/tmp/puma.service"
#  }

#  provisioner "remote-exec" {
#    script = "files/deploy.sh"
#  }

#  network_interface {
#    subnet_id = yandex_vpc_subnet.app-subnet.id
#    nat = true
#  }
#}


#resource "yandex_vpc_network" "app-network" {
#name = "reddit-app-network"
#}
#resource "yandex_vpc_subnet" "app-subnet" {
#name = "reddit-app-subnet"
#zone = "ru-central1-a"
#network_id = "${yandex_vpc_network.app-network.id}"
#v4_cidr_blocks = ["192.168.10.0/24"]
#}
