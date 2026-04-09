resource "cloudflare_dns_record" "lsferreira_net_spf" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "lsferreira.net"
  type    = "TXT"
  comment = "terraform"
  ttl     = 1
  content = "v=spf1 include:_spf.mx.cloudflare.net +ip4:193.108.130.14 +include:spf.mxyeet.net +include:_spf.lsferreira.net ~all"
}

moved {
  from = cloudflare_record.lsferreira_net_spf
  to   = cloudflare_dns_record.lsferreira_net_spf
}

resource "cloudflare_dns_record" "lsferreira_net_dmarc" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_dmarc"
  type    = "TXT"
  comment = "terraform"
  ttl     = 1
  content = "v=DMARC1;p=quarantine;sp=quarantine;pct=100;rua=mailto:cdbf63edcf5a46f6a003272a9f314ef1@dmarc-reports.cloudflare.net;ruf=mailto:cdbf63edcf5a46f6a003272a9f314ef1@dmarc-reports.cloudflare.net;ri=86400;aspf=s;adkim=s;fo=0:1:d:s;"
}

moved {
  from = cloudflare_record.lsferreira_net_dmarc
  to   = cloudflare_dns_record.lsferreira_net_dmarc
}

resource "cloudflare_dns_record" "lsferreira_net_dkim1" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "protonmail._domainkey"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "protonmail.domainkey.d3o6sspqrfqz73aqmw6ghj2f22kp3ob77j72axb34nj3dnhp4aqxa.domains.proton.ch"
}

moved {
  from = cloudflare_record.lsferreira_net_dkim1
  to   = cloudflare_dns_record.lsferreira_net_dkim1
}

resource "cloudflare_dns_record" "lsferreira_net_dkim2" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "protonmail2._domainkey"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "protonmail2.domainkey.d3o6sspqrfqz73aqmw6ghj2f22kp3ob77j72axb34nj3dnhp4aqxa.domains.proton.ch"
}

moved {
  from = cloudflare_record.lsferreira_net_dkim2
  to   = cloudflare_dns_record.lsferreira_net_dkim2
}

resource "cloudflare_dns_record" "lsferreira_net_dkim3" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "protonmail3._domainkey"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "protonmail3.domainkey.d3o6sspqrfqz73aqmw6ghj2f22kp3ob77j72axb34nj3dnhp4aqxa.domains.proton.ch"
}

moved {
  from = cloudflare_record.lsferreira_net_dkim3
  to   = cloudflare_dns_record.lsferreira_net_dkim3
}

resource "cloudflare_dns_record" "smtp" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "smtp"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}

moved {
  from = cloudflare_record.smtp
  to   = cloudflare_dns_record.smtp
}

resource "cloudflare_dns_record" "pop3" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "pop3"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}

moved {
  from = cloudflare_record.pop3
  to   = cloudflare_dns_record.pop3
}

# Alias to pop3
resource "cloudflare_dns_record" "pop" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "pop"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}

moved {
  from = cloudflare_record.pop
  to   = cloudflare_dns_record.pop
}

resource "cloudflare_dns_record" "imap" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "imap"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}

moved {
  from = cloudflare_record.imap
  to   = cloudflare_dns_record.imap
}

resource "cloudflare_dns_record" "autoconfig" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "autoconfig"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}

moved {
  from = cloudflare_record.autoconfig
  to   = cloudflare_dns_record.autoconfig
}

resource "cloudflare_dns_record" "autodiscover" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "autodiscover"
  proxied = false
  type    = "CNAME"
  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}

moved {
  from = cloudflare_record.autodiscover
  to   = cloudflare_dns_record.autodiscover
}

resource "cloudflare_dns_record" "srv_autoconfig" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_autoconfig._tcp"
  type    = "SRV"


  comment  = "terraform"
  ttl      = 1
  priority = 0
  data = {
    name     = "lsferreira.net"
    service  = "_autoconfig._tcp._autoconfig"
    proto    = "_tcp"
    priority = 0
    weight   = 0
    port     = 443
    target   = "autoconfig.lsferreira.net"
  }
}

moved {
  from = cloudflare_record.srv_autoconfig
  to   = cloudflare_dns_record.srv_autoconfig
}

resource "cloudflare_dns_record" "srv_autodiscover" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_autodiscover._tcp"
  type    = "SRV"


  comment  = "terraform"
  ttl      = 1
  priority = 0
  data = {
    name     = "lsferreira.net"
    service  = "_autodiscover._tcp._autodiscover"
    proto    = "_tcp"
    priority = 0
    weight   = 0
    port     = 443
    target   = "autodiscover.lsferreira.net"
  }
}

moved {
  from = cloudflare_record.srv_autodiscover
  to   = cloudflare_dns_record.srv_autodiscover
}

resource "cloudflare_dns_record" "srv_smtp" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_submission._tcp"
  type    = "SRV"


  comment  = "terraform"
  ttl      = 1
  priority = 0
  data = {
    name     = "lsferreira.net"
    service  = "_submission._tcp._submission"
    proto    = "_tcp"
    priority = 0
    weight   = 0
    port     = 465
    target   = "smtp.lsferreira.net"
  }
}

moved {
  from = cloudflare_record.srv_smtp
  to   = cloudflare_dns_record.srv_smtp
}

resource "cloudflare_dns_record" "srv_pop3" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_pop3._tcp"
  type    = "SRV"


  comment  = "terraform"
  ttl      = 1
  priority = 0
  data = {
    name     = "lsferreira.net"
    service  = "_pop3._tcp._pop3"
    proto    = "_tcp"
    priority = 0
    weight   = 0
    port     = 110
    target   = "pop3.lsferreira.net"
  }
}

moved {
  from = cloudflare_record.srv_pop3
  to   = cloudflare_dns_record.srv_pop3
}

resource "cloudflare_dns_record" "srv_pop3s" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_pop3s._tcp"
  type    = "SRV"


  comment  = "terraform"
  ttl      = 1
  priority = 0
  data = {
    name     = "lsferreira.net"
    service  = "_pop3s._tcp._pop3s"
    proto    = "_tcp"
    priority = 0
    weight   = 0
    port     = 995
    target   = "pop3.lsferreira.net"
  }
}

moved {
  from = cloudflare_record.srv_pop3s
  to   = cloudflare_dns_record.srv_pop3s
}

resource "cloudflare_dns_record" "srv_imap" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_imap._tcp"
  type    = "SRV"


  comment  = "terraform"
  ttl      = 1
  priority = 0
  data = {
    name     = "lsferreira.net"
    service  = "_imap._tcp._imap"
    proto    = "_tcp"
    priority = 0
    weight   = 0
    port     = 143
    target   = "imap.lsferreira.net"
  }
}

moved {
  from = cloudflare_record.srv_imap
  to   = cloudflare_dns_record.srv_imap
}

resource "cloudflare_dns_record" "srv_imaps" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "_imaps._tcp"
  type    = "SRV"


  comment  = "terraform"
  ttl      = 1
  priority = 0
  data = {
    name     = "lsferreira.net"
    service  = "_imaps._tcp._imaps"
    proto    = "_tcp"
    priority = 0
    weight   = 0
    port     = 993
    target   = "imap.lsferreira.net"
  }
}

moved {
  from = cloudflare_record.srv_imaps
  to   = cloudflare_dns_record.srv_imaps
}

resource "cloudflare_dns_record" "webmail" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "webmail"
  type    = "CNAME"

  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}

moved {
  from = cloudflare_record.webmail
  to   = cloudflare_dns_record.webmail
}
