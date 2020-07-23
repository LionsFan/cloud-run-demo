provider "google" {
  version = "~> 3.5"
}

resource "google_cloud_run_service" "default" {
  name     = "cloud-run-demo"
  project  = var.project_id
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/cloud-run-demo"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
