output "artifact_repo" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}

output "cloud_run_service_name" {
  value = google_cloud_run_v2_service.api.name
}

output "cloud_run_uri" {
  value = google_cloud_run_v2_service.api.uri
}
