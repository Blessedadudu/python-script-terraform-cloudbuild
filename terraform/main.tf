provider "google" {
  project = "singular-agent-452813-n6"
  region  = "europe-west1"
}

variable "vm_name" {
  default = "docker-vm-55"
}

resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = "e2-micro"
  allow_stopping_for_update = true
  zone         = "europe-west1-c"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = "477570371233-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/devstorage.read_only"]
  }


  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata = {
    gce-container-declaration = <<EOT
    spec:
      containers:
        - name: dockerized-python-app
          image: gcr.io/singular-agent-452813-n6/dockerize-python-script-cicd
          stdin: false
          tty: false
      restartPolicy: Always
    EOT
  }
}
