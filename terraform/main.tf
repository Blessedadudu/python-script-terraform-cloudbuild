provider "google" {
  project = "singular-agent-452813-n6"
  region  = "europe-west1"
}

variable "vm_name" {
  default = "docker-vm-66"
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

  # ✅ Use a startup script instead of gce-container-declaration
  metadata_startup_script = <<EOT
#!/bin/bash
echo "Starting VM setup..."

# ✅ Install Docker if not already installed
if ! command -v docker &> /dev/null
then
    echo "Installing Docker..."
    apt update && apt install -y docker.io
    systemctl start docker
    systemctl enable docker
else
    echo "Docker is already installed."
fi

# ✅ Set environment variables
echo "WELCOME_MESSAGE=Hello from Cloud VM!" > /etc/docker.env
echo "SLEEP_TIME=5" >> /etc/docker.env
echo "PRODUCTION=1" >> /etc/docker.env

# ✅ Pull the latest image (ensure VM has internet access)
docker pull gcr.io/singular-agent-452813-n6/dockerize-python-script-cicd

# ✅ Run the container with environment variables
docker run --env-file /etc/docker.env -d gcr.io/singular-agent-452813-n6/dockerize-python-script-cicd

echo "Container started successfully!"
EOT
}
