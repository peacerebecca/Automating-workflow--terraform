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

Step 3:
Create a new folder under the parent folder and name it instance  
Add a new file named main.tf
Add a new file named variables





