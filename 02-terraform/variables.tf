locals {
  data_lake_bucket = "dtc_datalake"
}

variable "project" {
  description = "Your GCP project ID"
  default = "robust-channel-376701"
  type = string
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location"
  default = "southamerica-east1"
  type = string
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info"
  default = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery dataset that raw data (from GCS) will be written to"
  type = string
  default = "trips_data_all"
}

variable "TABLE_NAME" {
  description = "BigQuery table"
  type = string
  default = "ny_trips"
}