resource "cloudflare_dns_record" "txt_protonmail_verify" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "protonmail-verification=70cccbdc7c9d67117259cae0540686df67aa782f"
}

moved {
  from = cloudflare_record.txt_protonmail_verify
  to   = cloudflare_dns_record.txt_protonmail_verify
}

resource "cloudflare_dns_record" "txt_google_verify" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "google-site-verification=GDP0s9B0oHyrvGkd95NkXaNLRJvzC49CYLSzCHJyEaw"
}

moved {
  from = cloudflare_record.txt_google_verify
  to   = cloudflare_dns_record.txt_google_verify
}

resource "cloudflare_dns_record" "txt_keybase_verify" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "keybase-site-verification=V_PHY7UrKUjJ0V0NpUfi-uJBTYS-UBZCtScmP65VLyI"
}

moved {
  from = cloudflare_record.txt_keybase_verify
  to   = cloudflare_dns_record.txt_keybase_verify
}

resource "cloudflare_dns_record" "txt_brave_verify" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "brave-ledger-verification=cd8be7b9dafc3349d08c6adff904af7629173c8b42ccff04926f3317c0da823a"
}

moved {
  from = cloudflare_record.txt_brave_verify
  to   = cloudflare_dns_record.txt_brave_verify
}

resource "cloudflare_dns_record" "txt_ovhcontrol_verify" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ovhcontrol.lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "aQUwzlKMuQ4XvI2nW76rxA"
}

moved {
  from = cloudflare_record.txt_ovhcontrol_verify
  to   = cloudflare_dns_record.txt_ovhcontrol_verify
}

resource "cloudflare_dns_record" "txt_ovhcontrol_status_verify" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ovhcontrol.status.lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "aQUwzlKMuQ4XvI2nW76rxA"
}

moved {
  from = cloudflare_record.txt_ovhcontrol_status_verify
  to   = cloudflare_dns_record.txt_ovhcontrol_status_verify
}

resource "cloudflare_dns_record" "txt_workspace_verification" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "workspace-verification.lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "efac3cf7-bddb-4d94-a3ba-9ac6e2f76839"
}

moved {
  from = cloudflare_record.txt_workspace_verification
  to   = cloudflare_dns_record.txt_workspace_verification
}

resource "cloudflare_dns_record" "txt_workspace_verification_mail" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "workspace-verification.mail.lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "efac3cf7-bddb-4d94-a3ba-9ac6e2f76839"
}

moved {
  from = cloudflare_record.txt_workspace_verification_mail
  to   = cloudflare_dns_record.txt_workspace_verification_mail
}

resource "cloudflare_dns_record" "txt_workspace_verification_fwd_mail" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "workspace-verification.fwd.mail.lsferreira.net"
  type    = "TXT"

  comment = "terraform"
  ttl     = 1
  content = "efac3cf7-bddb-4d94-a3ba-9ac6e2f76839"
}
moved {
  from = cloudflare_record.txt_workspace_verification_fwd_mail
  to   = cloudflare_dns_record.txt_workspace_verification_fwd_mail
}
