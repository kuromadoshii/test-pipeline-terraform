terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }

  backend "s3" {
    bucket = "vini-remote-state"                   #qual bucket sera usado
    key    = "pipeline-github-actions/terraform.tfstate"   #pasta que sera usada/criada no bucket onde fica o terraform state
    region = "us-west-2"                           #região do bucket
  }
}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      owner      = "Vinicius Gmail"
      managed-by = "curso-terraform"

    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "vini-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-west-2"
  }
}