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


variable "zone_name" {
    default = "kalpanadevops.online"
}

variable "zone_id" {
    default = "Z01584833LT7LVUACGA1"
}