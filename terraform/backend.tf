terraform {
  backend "s3" {
    bucket = "revansh-rachit-007"
    key    = "sever_name/statefile"
    region = "us-east-1"
  }
}