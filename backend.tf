terraform {
  backend "s3" {
    bucket = "onpassive-pt-statefile"
    key    = "chatbotb2b-pt/terraform.tfstate"
    region = "us-east-1"
  }
}