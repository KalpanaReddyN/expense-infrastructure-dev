module "vpc" {
    #source = "../terraform-aws-vpc"
    source = "git::https://github.com/KalpanaReddyN/terraform-aws-vpc.git?ref=main"
    project_name = var.project_name  # we wrote here bcoz didnt mention this in varibales.tf in terraform-aws-vpc
    environment = var.environment  # we can keep these in variables also and changed here.
    common_tags = var.common_tags
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    is_peering_required = var.is_peering_required
}
