
data "authentik_flow" "authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_flow" "invalidation-flow" {
  slug = "default-provider-invalidation-flow"
}

data "authentik_certificate_key_pair" "domain" {
  name = "domain"
}

data "authentik_property_mapping_provider_scope" "scope-email" {
  name = "authentik default OAuth Mapping: OpenID 'email'"
}

data "authentik_property_mapping_provider_scope" "scope-profile" {
  name = "authentik default OAuth Mapping: OpenID 'profile'"
}

data "authentik_property_mapping_provider_scope" "scope-openid" {
  name = "authentik default OAuth Mapping: OpenID 'openid'"
}

