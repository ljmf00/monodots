terraform {
  required_providers {
    infisical = {
      source  = "infisical/infisical"
      version = "0.16.15"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.19.0-beta.5"
    }
  }
}

provider "infisical" {
  client_id     = "${var.infisical_client_id}"
  client_secret = "${var.infisical_client_secret}"
}

provider "cloudflare" {
  api_token = data.infisical_secrets.common_secrets.secrets["API_CLOUDFLARE_TOKEN_TERRAFORM"].value
}
