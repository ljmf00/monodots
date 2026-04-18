resource "cloudflare_argo_tiered_caching" "lsferreira_net" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  value   = "on"
}

moved {
  from = cloudflare_argo.lsferreira_net
  to   = cloudflare_argo_tiered_caching.lsferreira_net
}

removed {
  from = cloudflare_zone_settings_override.lsferreira_net_settings
  lifecycle {
    destroy = false
  }
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_always_use_https" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "always_use_https"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_always_use_https
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/always_use_https"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_automatic_https_rewrites" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_automatic_https_rewrites
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/automatic_https_rewrites"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_brotli" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "brotli"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_brotli
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/brotli"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_browser_cache_ttl" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "browser_cache_ttl"
  value      = 14400
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_browser_cache_ttl
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/browser_cache_ttl"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_cache_level" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "cache_level"
  value      = "aggressive"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_cache_level
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/cache_level"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_challenge_ttl" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "challenge_ttl"
  value      = 86400
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_challenge_ttl
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/challenge_ttl"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_development_mode" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "development_mode"
  value      = "off"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_development_mode
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/development_mode"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_http3" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "http3"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_http3
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/http3"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_ipv6" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "ipv6"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_ipv6
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/ipv6"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_min_tls_version" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "min_tls_version"
  value      = "1.1"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_min_tls_version
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/min_tls_version"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_opportunistic_onion" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "opportunistic_onion"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_opportunistic_onion
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/opportunistic_onion"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_pseudo_ipv4" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "pseudo_ipv4"
  value      = "off"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_pseudo_ipv4
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/pseudo_ipv4"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_rocket_loader" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "rocket_loader"
  value      = "off"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_rocket_loader
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/rocket_loader"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_security_level" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "security_level"
  value      = "high"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_security_level
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/security_level"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_ssl" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "ssl"
  value      = "strict"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_ssl
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/ssl"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_tls_1_3" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "tls_1_3"
  value      = "zrt"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_tls_1_3
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/tls_1_3"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_websockets" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "websockets"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_websockets
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/websockets"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_zero_rtt" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "0rtt"
  value      = "on"
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_zero_rtt
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/0rtt"
}

resource "cloudflare_zone_setting" "lsferreira_net_settings_minify" {
  zone_id    = data.cloudflare_zones.lsferreira_net.result[0].id
  setting_id = "minify"
  value = {
    css  = "on"
    html = "on"
    js   = "on"
  }
}

import {
  to = cloudflare_zone_setting.lsferreira_net_settings_minify
  id = "${data.cloudflare_zones.lsferreira_net.result[0].id}/minify"
}

removed {
  from = cloudflare_zone_settings_override.lsferreira_net_settings
  lifecycle {
    destroy = false
  }
  # NOTE: The import blocks above are only valid in the root Terraform module.
  # If this file is a child module, move the import blocks to your root
  # module and prefix 'to' with the module path:
  #   to = module.mymod.cloudflare_zone_setting.lsferreira_net_settings_<setting>
}