Automating our Workflows with Terraform.
In this lab, we shall create vitual private cloud networks, subnets and virtual machines automatically using Terraform.

Prerequisites
Google Cloud Account and Project 
Google Cloud Credits - **https://trygcp.dev/e/build-ai-NA01**

Step 1:
Create a folder of your choice using mkdir foldername for the Terraform configuration
Using the editor, Create a new folder inside the created folder and name it provider.tf
add: provider "google" {}

In the terminal, change directory to your foldername and innitialize terraform
example
cd devfestNairobi
terraform init

Step 2:
Create the auto mode network "devfestoffice" along with its firewall rule and two VM instances (office_vm_1 and office_vm_2).
Create a new file called mynetwork.tf
# Create the mynetwork network
resource "google_compute_network" "mynetwork" {
  name = "devfestoffice"
  # Add resource properties 
  auto_create_subnetworks = "true"
}
# Add a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on mynetwork
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
  name = "devfestoffice-allow-http-ssh-rdp-icmp"
  # Add resource properties
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

# Create office instance1
module "mynet-vm-1" {
  source           = "./instance"
  instance_name    = "officevm1"
  instance_zone    = "us-east1-c"
  instance_network = google_compute_network.mynetwork.self_link
}
# Create the devfest2" instance
module "mynet-vm-2" {
  source           = "./instance"
  instance_name    = "officevm2"
  instance_zone    = "us-central1-b"
  instance_network = google_compute_network.mynetwork.self_link
}   
}

Step 3:
Create a new folder under the parent folder and name it instance  
Add a new file named main.tf
resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}"
  zone         = "${var.instance_zone}"
  machine_type = "${var.instance_type}"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      }
  }
  network_interface {
    network = "${var.instance_network}"
    access_config {
      # Allocate a one-to-one NAT IP to the instance
    }
  }
}

Add a new file named variables

variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {
  default = "e2-micro"
  }
variable "instance_network" {}



