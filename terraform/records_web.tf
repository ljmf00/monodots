resource "cloudflare_record" "root_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "lsferreira.net"
  value = "ft-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "www_root_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "www.lsferreira.net"
  value = "ft-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "s_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "s.lsferreira.net"
  value = "nc-anx04-1.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "rss_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "rss.lsferreira.net"
  value = "ft-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "social_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "social.lsferreira.net"
  value = "ft-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "feed_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "feed.lsferreira.net"
  value = "ft-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "inventory_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "inventory.lsferreira.net"
  value = "ft-s-lu-04.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "metrics_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "metrics.lsferreira.net"
  value = "nc-anx04-1.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "my_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "my.lsferreira.net"
  value = "nc-anx04-1.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "search_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "search.lsferreira.net"
  value = "k8s.internal.lsferreira.net"
  type = "CNAME"
  proxied = true

  comment = "terraform"
}

resource "cloudflare_record" "bridge_rss_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "bridge.rss.lsferreira.net"
  value = "k8s.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "status_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "status.lsferreira.net"
  value = "statuspage.betteruptime.com"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "home_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "home.lsferreira.net   "
  value = "2.80.252.193"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "epg_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "epg.lsferreira.net"
  value = "r.forwarddomain.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "epg_txt_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "_.epg.lsferreira.net"
  value = "forward-domain=https://epgshare01.online/epgshare01/epg_ripper_ALL_SOURCES1.xml.gz"
  type = "TXT"

  comment = "terraform"
}

resource "cloudflare_record" "iptv_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "iptv.lsferreira.net"
  value = "r.forwarddomain.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "iptv_txt_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "_.iptv.lsferreira.net"
  value = "forward-domain=https://iptv-org.github.io/iptv/index.m3u"
  type = "TXT"

  comment = "terraform"
}
