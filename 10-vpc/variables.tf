variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}

variable "public_subnet_cidrs" {
    default = ["10.0.1.0/24", "10.0.2.0/24"] # if u mention 1 or 3 we get error
}

variable "private_subnet_cidrs" {
    default = ["10.0.11.0/24", "10.0.12.0/24"] # if u mention 1 we get error
}

variable "database_subnet_cidrs" {
    default = ["10.0.21.0/24", "10.0.22.0/24"] # if u mention 1 we get error
}

variable "is_peering_required" {
    default = true
}
