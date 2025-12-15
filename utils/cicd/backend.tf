# tflint-ignore: terraform_required_version
terraform {
  backend "s3" {
    # these are injected from env vars by CICD
    bucket       = "VAR-TF_STATE_BUCKET"
    region       = "VAR-AWS_REGION"
    key          = "console-ui-cicd-VAR-TF_STATE_FILEMANE.tfstate"
    use_lockfile = true
  }
}
