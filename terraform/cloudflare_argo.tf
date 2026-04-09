
resource "cloudflare_argo_tiered_caching" "lsferreira_net" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  value   = "on"
}

moved {
  from = cloudflare_argo.lsferreira_net
  to   = cloudflare_argo_tiered_caching.lsferreira_net
}
