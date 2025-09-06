terraform {
  required_version = ">= 1.11.1"
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
