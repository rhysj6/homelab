locals {
    k8s_host = "https://${var.kubevip}:6443"
    k8s_cluster_ca_certificate = base64decode(talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.ca_certificate)
    k8s_client_certificate = base64decode(talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.client_certificate)
    k8s_client_key = base64decode(talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.client_key)
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}

resource "infisical_secret" "k8s_host" {
  name         = "HOST"
  value        = local.k8s_host
  env_slug     = "main"
  workspace_id = "a313cae1-beb5-408e-be83-83fa189863b6"
  folder_path  = "/kubeconfigs/${var.cluster_name}"
}

resource "infisical_secret" "k8s_cluster_ca_certificate" {
  name         = "CLUSTER_CA_CERTIFICATE"
  value        = local.k8s_cluster_ca_certificate
  env_slug     = "main"
  workspace_id = "a313cae1-beb5-408e-be83-83fa189863b6"
  folder_path  = "/kubeconfigs/${var.cluster_name}"
}

resource "infisical_secret" "k8s_client_certificate" {
  name         = "CLIENT_CERTIFICATE"
  value        = local.k8s_client_certificate
  env_slug     = "main"
  workspace_id = "a313cae1-beb5-408e-be83-83fa189863b6"
  folder_path  = "/kubeconfigs/${var.cluster_name}"
}

resource "infisical_secret" "k8s_client_key" {
  name         = "CLIENT_KEY"
  value        = local.k8s_client_key
  env_slug     = "main"
  workspace_id = "a313cae1-beb5-408e-be83-83fa189863b6"
  folder_path  = "/kubeconfigs/${var.cluster_name}"
}