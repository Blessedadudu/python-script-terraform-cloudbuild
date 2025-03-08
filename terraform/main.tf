provider "google" {
  project = "singular-agent-452813-n6"
  region  = "europe-west1"
}

resource "google_compute_instance" "vm" {
  name         = "docker-vm-22"
  machine_type = "e2-micro"
  zone         = "europe-west1-c"

  boot_disk {
    initialize_params {
     image = "projects/cos-cloud/global/images/family/cos-stable"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = "477570371233-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
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
