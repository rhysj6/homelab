locals {
    cilium_crd_exists = length(data.kubernetes_resources.cilium_crds.objects) > 0
    prometheus_crd_exists = length(data.kubernetes_resources.prometheus_crds.objects) > 0
    cert_manager_crd_exists = length(data.kubernetes_resources.cluster-issuer-crd.objects) > 0
    traefik_crd_exists = length(data.kubernetes_resources.traefik_crds.objects) > 0
}

data "kubernetes_resources" "cilium_crds" { ## Get the CRD if it exists
  api_version    = "apiextensions.k8s.io/v1"
  kind           = "CustomResourceDefinition"
  field_selector = "metadata.name=ciliumloadbalancerippools.cilium.io"
  limit          = 1
}

data "kubernetes_resources" "prometheus_crds" { ## Get the CRD if it exists
  api_version    = "apiextensions.k8s.io/v1"
  kind           = "CustomResourceDefinition"
  field_selector = "metadata.name=podmonitors.monitoring.coreos.com"
  limit          = 1
}

data "kubernetes_resources" "cluster-issuer-crd" {
  api_version    = "apiextensions.k8s.io/v1"
  kind           = "CustomResourceDefinition"
  field_selector = "metadata.name=clusterissuers.cert-manager.io"
  limit          = 1
}


data "kubernetes_resources" "traefik_crds" {
  api_version    = "apiextensions.k8s.io/v1"
  kind           = "CustomResourceDefinition"
  field_selector = "metadata.name=middlewares.traefik.io"
  limit          = 1
}