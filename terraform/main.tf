resource "google_compute_instance" "vm" {
  name         = "docker-vm-22"
  machine_type = "e2-micro"
  zone         = "europe-west1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Startup script running..."
    docker pull gcr.io/singular-agent-452813-n6/dockerize-python-script-cicd
    docker stop my-container || true
    docker rm my-container || true
    docker run -d --name my-container gcr.io/singular-agent-452813-n6/dockerize-python-script-cicd
  EOT

  # Prevents Terraform from destroying the VM
  lifecycle {
    ignore_changes = [metadata_startup_script]
  }
}
