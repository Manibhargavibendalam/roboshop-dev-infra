terraform {
    required_providers {
        aws = {
      source  = "hashicorp/aws"
      version = ">= 6.29.0"
    }
    }

    backend "s3" {
        bucket = "remote-state-chintu-dev"
        key = "roboshop-dev-sg"
        region = "us-east-1"
        use_lockfile = true
        encrypt = true
    }
}

provider "aws" {
    region = "us-east-1"
}