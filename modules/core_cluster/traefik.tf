resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik_crds" {
  chart       = "traefik-crds"
  repository  = "https://traefik.github.io/charts"
  name        = "traefik-crds"
  namespace   = kubernetes_namespace.traefik.id
  version     = "1.9.0"
  max_history = 2
}


resource "helm_release" "traefik" {
  chart       = "traefik"
  repository  = "https://traefik.github.io/charts"
  name        = "traefik"
  namespace   = kubernetes_namespace.traefik.id
  version     = "36.3.0"
  max_history = 2
  depends_on  = [helm_release.traefik_crds, kubernetes_namespace.traefik]
  values = [
    templatefile("${path.module}/templates/traefik_values.yaml", {
      cilium_crds = data.kubernetes_resources.cilium_crds.objects
      service_ip        = var.ingress_controller_ip
    })
  ]
}
