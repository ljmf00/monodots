moved {
  from = cloudflare_record.root_lsferreira
  to   = cloudflare_dns_record.root_lsferreira
}

moved {
  from = cloudflare_record.www_root_lsferreira
  to   = cloudflare_dns_record.www_root_lsferreira
}

moved {
  from = cloudflare_record.s_lsferreira
  to   = cloudflare_dns_record.s_lsferreira
}

moved {
  from = cloudflare_record.social_lsferreira
  to   = cloudflare_dns_record.social_lsferreira
}

moved {
  from = cloudflare_record.feed_lsferreira
  to   = cloudflare_dns_record.feed_lsferreira
}

moved {
  from = cloudflare_record.inventory_lsferreira
  to   = cloudflare_dns_record.inventory_lsferreira
}

moved {
  from = cloudflare_record.metrics_lsferreira
  to   = cloudflare_dns_record.metrics_lsferreira
}

moved {
  from = cloudflare_record.my_lsferreira
  to   = cloudflare_dns_record.my_lsferreira
}

moved {
  from = cloudflare_record.search_lsferreira
  to   = cloudflare_dns_record.search_lsferreira
}

moved {
  from = cloudflare_record.search_staging_lsferreira
  to   = cloudflare_dns_record.search_staging_lsferreira
}

moved {
  from = cloudflare_record.rss_staging_lsferreira
  to   = cloudflare_dns_record.rss_staging_lsferreira
}

moved {
  from = cloudflare_record.rss_lsferreira
  to   = cloudflare_dns_record.rss_lsferreira
}

moved {
  from = cloudflare_record.status_lsferreira
  to   = cloudflare_dns_record.status_lsferreira
}

moved {
  from = cloudflare_record.home_lsferreira
  to   = cloudflare_dns_record.home_lsferreira
}

moved {
  from = cloudflare_record.epg_lsferreira
  to   = cloudflare_dns_record.epg_lsferreira
}

moved {
  from = cloudflare_record.epg_txt_lsferreira
  to   = cloudflare_dns_record.epg_txt_lsferreira
}

moved {
  from = cloudflare_record.iptv_lsferreira
  to   = cloudflare_dns_record.iptv_lsferreira
}

moved {
  from = cloudflare_record.iptv_txt_lsferreira
  to   = cloudflare_dns_record.iptv_txt_lsferreira
}

resource "cloudflare_dns_record" "root_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "lsferreira.net"
  content = "nmc-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "www_root_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "www.lsferreira.net"
  content = "nmc-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "s_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "s.lsferreira.net"
  content = "nc-anx04-1.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "social_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "social.lsferreira.net"
  content = "nmc-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "feed_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "feed.lsferreira.net"
  content = "nmc-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "inventory_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "inventory.lsferreira.net"
  content = "nmc-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "search_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "search.lsferreira.net"
  content = "gateway.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "search_staging_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "search.staging.lsferreira.net"
  content = "gateway.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "rss_staging_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "rss.staging.lsferreira.net"
  content = "gateway.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "rss_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "rss.lsferreira.net"
  content = "gateway.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "status_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "status.lsferreira.net"
  content = "statuspage.betteruptime.com"
  type = "CNAME"
  proxied = false

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "home_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "home.lsferreira.net"
  content = "lsferreira.duckdns.org"
  type = "CNAME"
  proxied = false

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "epg_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "epg.lsferreira.net"
  content = "r.forwarddomain.net"
  type = "CNAME"
  proxied = false

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "epg_txt_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "_.epg.lsferreira.net"
  content = "forward-domain=https://epgshare01.online/epgshare01/epg_ripper_ALL_SOURCES1.xml.gz"
  type = "TXT"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "iptv_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "iptv.lsferreira.net"
  content = "r.forwarddomain.net"
  type = "CNAME"
  proxied = false

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "iptv_txt_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "_.iptv.lsferreira.net"
  content = "forward-domain=https://iptv-org.github.io/iptv/index.m3u"
  type = "TXT"

  comment = "managed by terraform"
}
