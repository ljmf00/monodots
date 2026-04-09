resource "cloudflare_dns_record" "root_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nmc-s-lu-04.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.root_lsferreira
  to   = cloudflare_dns_record.root_lsferreira
}

resource "cloudflare_dns_record" "www_root_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "www.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nmc-s-lu-04.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.www_root_lsferreira
  to   = cloudflare_dns_record.www_root_lsferreira
}

resource "cloudflare_dns_record" "s_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "s.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nc-anx04-1.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.s_lsferreira
  to   = cloudflare_dns_record.s_lsferreira
}

resource "cloudflare_dns_record" "social_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "social.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nmc-s-lu-04.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.social_lsferreira
  to   = cloudflare_dns_record.social_lsferreira
}

resource "cloudflare_dns_record" "feed_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "feed.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nmc-s-lu-04.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.feed_lsferreira
  to   = cloudflare_dns_record.feed_lsferreira
}

resource "cloudflare_dns_record" "inventory_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "inventory.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nmc-s-lu-04.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.inventory_lsferreira
  to   = cloudflare_dns_record.inventory_lsferreira
}

resource "cloudflare_dns_record" "metrics_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "metrics.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nc-anx04-1.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.metrics_lsferreira
  to   = cloudflare_dns_record.metrics_lsferreira
}

resource "cloudflare_dns_record" "my_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "my.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "nc-anx04-1.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.my_lsferreira
  to   = cloudflare_dns_record.my_lsferreira
}

resource "cloudflare_dns_record" "search_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "search.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "gateway.lsferreira.net"
}

moved {
  from = cloudflare_record.search_lsferreira
  to   = cloudflare_dns_record.search_lsferreira
}

resource "cloudflare_dns_record" "search_staging_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "search.staging.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "gateway.lsferreira.net"
}

moved {
  from = cloudflare_record.search_staging_lsferreira
  to   = cloudflare_dns_record.search_staging_lsferreira
}

resource "cloudflare_dns_record" "rss_staging_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "rss.staging.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "gateway.lsferreira.net"
}

moved {
  from = cloudflare_record.rss_staging_lsferreira
  to   = cloudflare_dns_record.rss_staging_lsferreira
}

resource "cloudflare_dns_record" "rss_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "rss.lsferreira.net"
  type    = "CNAME"
  proxied = true

  comment = "terraform"
  ttl     = 1
  content = "gateway.lsferreira.net"
}

moved {
  from = cloudflare_record.rss_lsferreira
  to   = cloudflare_dns_record.rss_lsferreira
}

resource "cloudflare_dns_record" "status_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "status.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "statuspage.betteruptime.com"
}

moved {
  from = cloudflare_record.status_lsferreira
  to   = cloudflare_dns_record.status_lsferreira
}

resource "cloudflare_dns_record" "home_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "home.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "188.80.144.16"
}

moved {
  from = cloudflare_record.home_lsferreira
  to   = cloudflare_dns_record.home_lsferreira
}

resource "cloudflare_dns_record" "epg_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "epg.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "r.forwarddomain.net"
}

moved {
  from = cloudflare_record.epg_lsferreira
  to   = cloudflare_dns_record.epg_lsferreira
}

resource "cloudflare_dns_record" "epg_txt_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_.epg.lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "forward-domain=https://epgshare01.online/epgshare01/epg_ripper_ALL_SOURCES1.xml.gz"
}

moved {
  from = cloudflare_record.epg_txt_lsferreira
  to   = cloudflare_dns_record.epg_txt_lsferreira
}

resource "cloudflare_dns_record" "iptv_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "iptv.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "r.forwarddomain.net"
}

moved {
  from = cloudflare_record.iptv_lsferreira
  to   = cloudflare_dns_record.iptv_lsferreira
}

resource "cloudflare_dns_record" "iptv_txt_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_.iptv.lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "forward-domain=https://iptv-org.github.io/iptv/index.m3u"
}

moved {
  from = cloudflare_record.iptv_txt_lsferreira
  to   = cloudflare_dns_record.iptv_txt_lsferreira
}
