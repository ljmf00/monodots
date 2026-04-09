moved {
  from = cloudflare_record.lsferreira_net_spf
  to   = cloudflare_dns_record.lsferreira_net_spf
}

moved {
  from = cloudflare_record.lsferreira_net_dmarc
  to   = cloudflare_dns_record.lsferreira_net_dmarc
}

moved {
  from = cloudflare_record.lsferreira_net_dkim1
  to   = cloudflare_dns_record.lsferreira_net_dkim1
}

moved {
  from = cloudflare_record.lsferreira_net_dkim2
  to   = cloudflare_dns_record.lsferreira_net_dkim2
}

moved {
  from = cloudflare_record.lsferreira_net_dkim3
  to   = cloudflare_dns_record.lsferreira_net_dkim3
}

moved {
  from = cloudflare_record.smtp
  to   = cloudflare_dns_record.smtp
}

moved {
  from = cloudflare_record.pop3
  to   = cloudflare_dns_record.pop3
}

moved {
  from = cloudflare_record.pop
  to   = cloudflare_dns_record.pop
}

moved {
  from = cloudflare_record.imap
  to   = cloudflare_dns_record.imap
}

moved {
  from = cloudflare_record.autoconfig
  to   = cloudflare_dns_record.autoconfig
}

moved {
  from = cloudflare_record.autodiscover
  to   = cloudflare_dns_record.autodiscover
}

moved {
  from = cloudflare_record.srv_autoconfig
  to   = cloudflare_dns_record.srv_autoconfig
}

moved {
  from = cloudflare_record.srv_autodiscover
  to   = cloudflare_dns_record.srv_autodiscover
}

moved {
  from = cloudflare_record.srv_smtp
  to   = cloudflare_dns_record.srv_smtp
}

moved {
  from = cloudflare_record.srv_pop3
  to   = cloudflare_dns_record.srv_pop3
}

moved {
  from = cloudflare_record.srv_pop3s
  to   = cloudflare_dns_record.srv_pop3s
}

moved {
  from = cloudflare_record.srv_imap
  to   = cloudflare_dns_record.srv_imap
}

moved {
  from = cloudflare_record.srv_imaps
  to   = cloudflare_dns_record.srv_imaps
}

moved {
  from = cloudflare_record.webmail
  to   = cloudflare_dns_record.webmail
}

# =============================================================================
# SPF / DMARC
# =============================================================================

resource "cloudflare_dns_record" "lsferreira_net_spf" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "lsferreira.net"
  content = "v=spf1 include:_spf.mx.cloudflare.net +ip4:193.108.130.14 +include:spf.mxyeet.net +include:_spf.lsferreira.net ~all"
  type = "TXT"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "lsferreira_net_dmarc" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "_dmarc"
  content = "v=DMARC1;p=quarantine;sp=quarantine;pct=100;rua=mailto:cdbf63edcf5a46f6a003272a9f314ef1@dmarc-reports.cloudflare.net;ruf=mailto:cdbf63edcf5a46f6a003272a9f314ef1@dmarc-reports.cloudflare.net;ri=86400;aspf=s;adkim=s;fo=0:1:d:s;"
  type = "TXT"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "lsferreira_net_dkim1" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "protonmail._domainkey"
  content = "protonmail.domainkey.d3o6sspqrfqz73aqmw6ghj2f22kp3ob77j72axb34nj3dnhp4aqxa.domains.proton.ch"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "lsferreira_net_dkim2" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "protonmail2._domainkey"
  content = "protonmail2.domainkey.d3o6sspqrfqz73aqmw6ghj2f22kp3ob77j72axb34nj3dnhp4aqxa.domains.proton.ch"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "lsferreira_net_dkim3" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "protonmail3._domainkey"
  content = "protonmail3.domainkey.d3o6sspqrfqz73aqmw6ghj2f22kp3ob77j72axb34nj3dnhp4aqxa.domains.proton.ch"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

# =============================================================================
# MANUAL CONFIGURATION
# =============================================================================

resource "cloudflare_dns_record" "smtp" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "smtp"
  content = "lu-shared04.cpanelplatform.com"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "pop3" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "pop3"
  content = "lu-shared04.cpanelplatform.com"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

# Alias to pop3
resource "cloudflare_dns_record" "pop" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "pop"
  content = "lu-shared04.cpanelplatform.com"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "imap" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "imap"
  content = "lu-shared04.cpanelplatform.com"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}


# =============================================================================
# AUTO CONFIGURATION
# =============================================================================

resource "cloudflare_dns_record" "autoconfig" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "autoconfig"
  content = "lu-shared04.cpanelplatform.com"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "autodiscover" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "autodiscover"
  content = "lu-shared04.cpanelplatform.com"
  proxied = false
  type = "CNAME"

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "srv_autoconfig" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1
  priority = 0

  name    = "_autoconfig._tcp"
  type    = "SRV"

  data = {
    priority = 0
    weight   = 0
    port     = 443
    target   = "autoconfig.lsferreira.net"
  }

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "srv_autodiscover" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1
  priority = 0

  name    = "_autodiscover._tcp"
  type    = "SRV"

  data = {
    priority = 0
    weight   = 0
    port     = 443
    target   = "autodiscover.lsferreira.net"
  }

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "srv_smtp" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1
  priority = 0

  name    = "_submission._tcp"
  type    = "SRV"

  data = {
    priority = 0
    weight   = 0
    port     = 465
    target   = "smtp.lsferreira.net"
  }

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "srv_pop3" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1
  priority = 0

  name    = "_pop3._tcp"
  type    = "SRV"

  data = {
    priority = 0
    weight   = 0
    port     = 110
    target   = "pop3.lsferreira.net"
  }

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "srv_pop3s" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name    = "_pop3s._tcp"
  type    = "SRV"

  data = {
    priority = 0
    weight   = 0
    port     = 995
    target   = "pop3.lsferreira.net"
  }

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "srv_imap" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name    = "_imap._tcp"
  type    = "SRV"

  data = {
    priority = 0
    weight   = 0
    port     = 143
    target   = "imap.lsferreira.net"
  }

  comment = "managed by terraform"
}

resource "cloudflare_dns_record" "srv_imaps" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name    = "_imaps._tcp"
  type    = "SRV"

  data = {
    priority = 0
    weight   = 0
    port     = 993
    target   = "imap.lsferreira.net"
  }

  comment = "managed by terraform"
}

# =============================================================================
# WEBMAIL
# =============================================================================

resource "cloudflare_dns_record" "webmail" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  ttl = 1

  name = "webmail"
  content = "lu-shared04.cpanelplatform.com"
  type = "CNAME"

  comment = "managed by terraform"
}