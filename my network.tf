# Create the mynetwork network
resource "google_compute_network" "mynetwork" {
  name = "mynetwork"
  # RESOURCE properties go here
  auto_create_subnetworks = "true"
}
# Add a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on mynetwork
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
  name = "mynetwork-allow-http-ssh-rdp-icmp"
  # RESOURCE properties go here
  network = google_compute_network.mynetwork.self_link
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}
# Create devfest1 instance
module "mynet-vm-1" {
  source           = "./instance"
  instance_name    = "devfest1"
  instance_zone    = "us-east1-c"
  instance_network = google_compute_network.mynetwork.self_link
}
# Create the devfest2" instance
module "mynet-vm-2" {
  source           = "./instance"
  instance_name    = "devfest2"
  instance_zone    = "us-central1-b"
  instance_network = google_compute_network.mynetwork.self_link
}
