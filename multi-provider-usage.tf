resource "aws_instance" "web_east" {
  provider = aws.east
  ami      = "ami-123456"
  instance_type = "t2.micro"
}

resource "aws_instance" "web_west" {
  provider = aws.west
  ami      = "ami-654321"
  instance_type = "t2.micro"
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-google-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  provider     = google
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
  }
}

#Terraform's multi-provider support allows you to provision resources in AWS and Google Cloud seamlessly
#The provider keyword associates a resource with a specific cloud provider.
#The aws.east and aws.west represent different AWS provider configurations (e.g., for separate regions).
#The google provider handles resources in Google Cloud.

#This configuration demonstrates how Terraform can manage resources across multiple cloud providers simultaneously

#The aws_instance resources create virtual machines (EC2 instances) in AWS.
#The google_compute_instance creates a virtual machine in Google Cloud.