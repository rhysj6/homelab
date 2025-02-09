resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.id
  version    = "1.17.0"
  max_history = 2
  set {
    name  = "crds.enabled"
    value = "true"
  }
}

resource "kubernetes_secret" "cluster_issuer" {
  metadata {
    name      = "cluster-issuer"
    namespace = kubernetes_namespace.cert_manager.metadata[0].name
  }
  data = {
    "cloudflare-api-token" = data.infisical_secrets.kubernetes.secrets["cloudflare_api_key"].value
  }
}

data "cloudflare_zones" "zones" {}

resource "kubernetes_manifest" "cluster_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "cert-manager"
    }
    spec = {
      acme = {
        # The ACME server URL
        server = "https://acme-v02.api.letsencrypt.org/directory"
        # Email address used for ACME registration
        email = data.infisical_secrets.bootstrap.secrets["cloudflare_email"].value
        # Name of a secret used to store the ACME account private key
        privateKeySecretRef = {
          name = "cert-manager-private-key"
        }
        # Enable the HTTP-01 challenge provider
        solvers = [
          {
            dns01 = {
              cloudflare = {
                email = data.infisical_secrets.bootstrap.secrets["cloudflare_email"].value
                apiTokenSecretRef = {
                  name = "cluster-issuer"
                  key  = "cloudflare-api-token"
                }
              }
            }
            selector = {
              dnsZones = [for zone in data.cloudflare_zones.zones.result : zone.name]
            }
          }
        ]
      }
    }
  }
  depends_on = [kubernetes_namespace.cert_manager, helm_release.cert_manager, kubernetes_secret.cluster_issuer]
}
