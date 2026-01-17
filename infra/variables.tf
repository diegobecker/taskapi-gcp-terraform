variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "service_name" {
  type    = string
  default = "taskapi"
}

variable "artifact_repo" {
  type    = string
  default = "taskapi-repo"
}
