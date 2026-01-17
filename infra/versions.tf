terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "gcp-dotnet-react-iac-tfstate-20260116"
    prefix = "taskapi/terraform/state"
  }
}
