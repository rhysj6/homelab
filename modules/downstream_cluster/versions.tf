terraform {
  required_version = ">= 1.11.1"
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "6.1.4"
    }
    minio = {
      source  = "aminueza/minio"
      version = "3.2.3"
    }
  }
}