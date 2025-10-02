terraform {
  required_version = ">= 1.11.1"
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "8.2.1"
    }
    minio = {
      source  = "aminueza/minio"
      version = "3.6.5"
    }
  }
}