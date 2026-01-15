# CI/CD test deployment of filmdrop-ui. Note that we assume access to an AWS account which contains
# a VPC specifically tagged with { Name = "aws-controltower-VPC" } that contains the typical FilmDrop VPC
# setup with public/private subnets, networking, etc. See the main FilmDrop AWS Terraform modules 
# repository for more details.

# Query VPC details from the AWS account used for CI/CD
module "vpc-data" {
  source = "./vpc-data"
}

# Create the content bucket where the built UI will be deployed
resource "aws_s3_bucket" "filmdrop_ui_content" {
  bucket_prefix = "filmdrop-ui-content-"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "filmdrop_ui_content_ownership_controls" {
  bucket = aws_s3_bucket.filmdrop_ui_content.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "filmdrop_ui_content_public_access_block" {
  bucket = aws_s3_bucket.filmdrop_ui_content.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "filmdrop_ui_content_versioning" {
  bucket = aws_s3_bucket.filmdrop_ui_content.id
  versioning_configuration {
    status = "Enabled"
  }
}

module "main" {
  source                  = "../.."
  filmdrop_ui_logo_file   = "./logo.png"
  filmdrop_ui_config      = filebase64("./config.dev.json")
  filmdrop_ui_logo        = filebase64("./logo.png")
  filmdrop_ui_release_tag = "v6.1.1-0"
  filmdrop_ui_bucket_name = aws_s3_bucket.filmdrop_ui_content.id
  vpc_id                  = module.vpc-data.vpc_id
  vpc_private_subnet_ids  = module.vpc-data.private_subnet_ids
  vpc_security_group_ids  = [module.vpc-data.security_group_id]
}