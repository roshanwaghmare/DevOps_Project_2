terraform {
  backend "s3" {
    bucket = "jenkins-terraform-ansible-proj"
    key    = "sever_name/statefile"
    region = "us-east-1"
  }
}