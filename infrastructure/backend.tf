terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-two-tier-vamsee"
    key            = "terraform/statefile_ecs"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
