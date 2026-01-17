resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.artifact_repo
  description   = "Docker images for TaskApi"
  format        = "DOCKER"
}

resource "google_service_account" "cloud_run_sa" {
  account_id   = "${var.service_name}-run-sa"
  display_name = "Cloud Run service account for ${var.service_name}"
}

resource "google_cloud_run_v2_service" "api" {
  name     = var.service_name
  location = var.region

  template {
    service_account = google_service_account.cloud_run_sa.email

    containers {
      # image = "us-docker.pkg.dev/cloudrun/container/hello"
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.artifact_repo}/${var.service_name}:v2"

      ports {
        container_port = 8080
      }
    }
  }
}

# Permitir acesso público (para estudo)
resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  location = google_cloud_run_v2_service.api.location
  name     = google_cloud_run_v2_service.api.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
