resource "google_storage_bucket" "bucket" {
  name = "mashimaro-functions-test-bucket"
  location = "ASIA"
  storage_class = "NEARLINE"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function.zip"
  bucket = "${google_storage_bucket.bucket.name}"
  source = "function.zip"
}

resource "google_cloudfunctions_function" "function" {
  name                  = "SampleTerraformFunction"
  description           = "My function"
  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.bucket.name}"
  source_archive_object = "${google_storage_bucket_object.archive.name}"
  source_repository {
    url = ""
  }
  trigger_http          = true
  timeout               = 60
  entry_point           = "SampleTerraformFunction"
  labels {
    my-label = "my-label-value"
  }
  runtime = "go111"
  environment_variables {
    MY_ENV_VAR = "my-env-var-value"
  }
}