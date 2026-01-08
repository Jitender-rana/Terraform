resource "aws_s3_bucket" "mybucket" {
  bucket = "my-bucket"
  

  tags = {
    Name        = "My bucket"
    
  }
}

resource "aws_dynamodb_table" "my_app_table"{
    name =  "my-app-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "id"#lock id ke liye
    attribute {
      name = "id"
      type = "S"
    }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
  backend "s3" {
    bucket = "my-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "my-app-table"
    
  }
}