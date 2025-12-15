# CI/CD test deployment of console-ui. Note that we assume access to an AWS account which contains
# a VPC specifically tagged with { Name = "aws-controltower-VPC" } that contains the typical FilmDrop VPC
# setup with public/private subnets, networking, etc. See the main FilmDrop AWS Terraform modules 
# repository for more details.

# Query VPC details from the AWS account used for CI/CD
module "vpc-data" {
  source = "./vpc-data"
}

module "main" {
  source                  = "../.."
  filmdrop_ui_logo_file   = "../../logo.png"
  filmdrop_ui_config      = filebase64("../../config.dev.json")
  filmdrop_ui_logo        = filebase64("../../logo.png")
  filmdrop_ui_release_tag = "v6.1.1-0"
  vpc_id                  = module.vpc-data.vpc_id
  vpc_private_subnet_ids  = module.vpc-data.private_subnet_ids
  vpc_security_group_ids  = [module.vpc-data.security_group_id]
  console_ui_bucket_name  = "test-build-bucket"
}