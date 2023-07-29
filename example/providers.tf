
terraform {
  backend "s3" {
    profile        = "__AWS_PROFILE_NAME__"
    region         = "__AWS_REGION__"
    bucket         = "__AWS_BUCKET_NAME_FOR_DATADOG_MODULE__"
    key            = "development/DataDog/monitoring/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3"
    }
  }
}

provider "aws" {
  region  = var.AWS_REGION
  profile = var.AWS_PROFILE
}

provider "datadog" {
  api_key = jsondecode(data.aws_secretsmanager_secret_version.datadog_secrets.secret_string)["DATADOG_API_KEY"]
  app_key = jsondecode(data.aws_secretsmanager_secret_version.datadog_secrets.secret_string)["DATADOG_APP_KEY"]
  api_url = jsondecode(data.aws_secretsmanager_secret_version.datadog_secrets.secret_string)["DATADOG_API_URL"]
}
