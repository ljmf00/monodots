resource "cloudflare_record" "ft_s_lu_04_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-s-lu-04.internal.lsferreira.net"
  value = "lu-shared04.cpanelplatform.com"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "bak_ft_s_lu_04_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-s-lu-04._.lsferreira.net"
  value = "lu-shared04.cpanelplatform.com"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_s_lu_04_ptr_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "14.130.108.193.in-addr.arpa.lsferreira.net"
  value = "lu-shared04.cpanelplatform.com"
  type = "PTR"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "nc_anx04_1_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "nc-anx04-1.internal.lsferreira.net"
  value = "152.53.18.215"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_o_ams_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-01.internal.lsferreira.net"
  value = "85.208.9.230"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_o_ams_02_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-02.internal.lsferreira.net"
  value = "85.208.9.229"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_o_ams_03_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-03.internal.lsferreira.net"
  value = "151.243.213.17"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_o_ams_04_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-04.internal.lsferreira.net"
  value = "151.243.213.18"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "bak_nc_anx04_1_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "nc-anx04-1._.lsferreira.net"
  value = "152.53.18.215"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_p_de_frkt_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-p-de-frkt-01.internal.lsferreira.net"
  value = "92.112.125.156"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "198.251.90.61"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ch_gateway_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ch.gateway.lsferreira.net"
  value = "107.189.6.72"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "us1_gateway_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "us1.gateway.lsferreira.net"
  value = "209.141.55.108"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "us2_gateway_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "us2.gateway.lsferreira.net"
  value = "198.98.62.203"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "us3_gateway_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "us3.gateway.lsferreira.net"
  value = "45.61.188.200"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_p_de_frkt_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-p-de-frkt-01.internal.lsferreira.net"
  value = "2a12:bec4:1822:52::a"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "k8s_dh_p_de_frkt_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "k8s.internal.lsferreira.net"
  value = "92.112.125.156"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "k8s_dh_p_de_frkt_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "k8s.internal.lsferreira.net"
  value = "2a12:bec4:1822:52::a"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "master_k8s_dh_p_de_frkt_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "master.k8s.internal.lsferreira.net"
  value = "92.112.125.156"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "master_k8s_dh_p_de_frkt_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "master.k8s.internal.lsferreira.net"
  value = "2a12:bec4:1822:52::a"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "master_k3s_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "master.k3s.internal.lsferreira.net"
  value = "152.53.18.215"
  type = "A"
  proxied = false

  comment = "terraform"
}