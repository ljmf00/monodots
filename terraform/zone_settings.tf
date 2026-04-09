# tf-migrate: resource "cloudflare_zone_settings_override" "lsferreira_net_settings" {
# tf-migrate:   zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id

# tf-migrate:   settings {
# tf-migrate:     # SSL/TLS
# tf-migrate:     ssl             = "strict"
# tf-migrate:     tls_1_3         = "zrt"
# tf-migrate:     min_tls_version = "1.3"

# tf-migrate:     # HTTP(S)
# tf-migrate:     always_use_https         = "on"
# tf-migrate:     automatic_https_rewrites = "on"
# tf-migrate:     opportunistic_encryption = "on"
# tf-migrate:     /* http2 = "on" # read-only */
# tf-migrate:     http3 = "on"

# tf-migrate:     # Network
# tf-migrate:     zero_rtt   = "on"
# tf-migrate:     websockets = "on"

# tf-migrate:     # IPv4/IPv6
# tf-migrate:     pseudo_ipv4 = "off"
# tf-migrate:     ipv6        = "on"

# tf-migrate:     # Tor
# tf-migrate:     opportunistic_onion = "on"

# tf-migrate:     # Caching
# tf-migrate:     development_mode  = "off"
# tf-migrate:     cache_level       = "basic"
# tf-migrate:     browser_cache_ttl = 14400
# tf-migrate:     rocket_loader     = "off"
# tf-migrate:     minify {
# tf-migrate:       css  = "on"
# tf-migrate:       js   = "on"
# tf-migrate:       html = "on"
# tf-migrate:     }

# tf-migrate:     # Compression
# tf-migrate:     brotli = "on"

# tf-migrate:     # Security
# tf-migrate:     security_level = "high"
# tf-migrate:     challenge_ttl  = 86400
# tf-migrate:     security_header {
# tf-migrate:       enabled = true
# tf-migrate:     }
# tf-migrate:   }
# tf-migrate: }

removed {
  from = cloudflare_zone_settings_override.lsferreira_net_settings
  lifecycle {
    destroy = false
  }
}
