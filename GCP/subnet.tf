# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  project                  = var.project
  name                     = "private-subnet"
  ip_cidr_range            = "10.0.0.0/24"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.0.16.0/24"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.0.32.0/24"
  }
}

resource "google_compute_subnetwork" "public" {
  project                  = var.project
  name                     = "public-subnet"
  ip_cidr_range            = "10.1.0.0/24"
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = false

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.1.32.0/24"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.1.16.0/24"
  }
}

