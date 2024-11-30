terraform {
  backend "s3" {
    bucket = "terraform-cloudcoach"
    key    = "dev/terraformstatefile"
    region = "us-east-1"
    #dynamodb_table = "my-lock-table"
  }
}
