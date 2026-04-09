resource "cloudflare_dns_record" "master_k3s_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "master.k3s.internal.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "nc-anx04-1.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.master_k3s_cname_lsferreira
  to   = cloudflare_dns_record.master_k3s_cname_lsferreira
}

resource "cloudflare_dns_record" "master_k8s_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "master.k8s.internal.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "master.k3s.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.master_k8s_cname_lsferreira
  to   = cloudflare_dns_record.master_k8s_cname_lsferreira
}

resource "cloudflare_dns_record" "geo_gateway_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "geo.gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "198.251.90.61"
}

moved {
  from = cloudflare_record.geo_gateway_a_lsferreira
  to   = cloudflare_dns_record.geo_gateway_a_lsferreira
}

resource "cloudflare_dns_record" "nl_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "nl.gateway.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "dh-d-ams-01.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.nl_gateway_cname_lsferreira
  to   = cloudflare_dns_record.nl_gateway_cname_lsferreira
}

resource "cloudflare_dns_record" "au_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "au.gateway.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "nc-anx04-1.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.au_gateway_cname_lsferreira
  to   = cloudflare_dns_record.au_gateway_cname_lsferreira
}

resource "cloudflare_dns_record" "ch_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ch.gateway.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "ft-ch-kvm26.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.ch_gateway_cname_lsferreira
  to   = cloudflare_dns_record.ch_gateway_cname_lsferreira
}

resource "cloudflare_dns_record" "us1_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "us1.gateway.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "ft-lv-kvm28.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.us1_gateway_cname_lsferreira
  to   = cloudflare_dns_record.us1_gateway_cname_lsferreira
}

resource "cloudflare_dns_record" "us2_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "us2.gateway.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "uft-ny-kvm21.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.us2_gateway_cname_lsferreira
  to   = cloudflare_dns_record.us2_gateway_cname_lsferreira
}

resource "cloudflare_dns_record" "us3_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "us3.gateway.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "ft-mia-kvm11.internal.lsferreira.net"
}

moved {
  from = cloudflare_record.us3_gateway_cname_lsferreira
  to   = cloudflare_dns_record.us3_gateway_cname_lsferreira
}

resource "cloudflare_dns_record" "gateway_geo_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "198.251.90.61"
}

moved {
  from = cloudflare_record.gateway_geo_a_lsferreira
  to   = cloudflare_dns_record.gateway_geo_a_lsferreira
}

resource "cloudflare_dns_record" "gateway_nc_anx04_1_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "152.53.18.215"
}

moved {
  from = cloudflare_record.gateway_nc_anx04_1_a_lsferreira
  to   = cloudflare_dns_record.gateway_nc_anx04_1_a_lsferreira
}

resource "cloudflare_dns_record" "gateway_nc_anx04_1_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a0a:4cc0:1:1111::1"
}

moved {
  from = cloudflare_record.gateway_nc_anx04_1_aaaa_lsferreira
  to   = cloudflare_dns_record.gateway_nc_anx04_1_aaaa_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_ch_kvm26_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "107.189.6.72"
}

moved {
  from = cloudflare_record.gateway_ft_ch_kvm26_a_lsferreira
  to   = cloudflare_dns_record.gateway_ft_ch_kvm26_a_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_ch_kvm26_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:30:f891:e42b::1"
}

moved {
  from = cloudflare_record.gateway_ft_ch_kvm26_aaaa_lsferreira
  to   = cloudflare_dns_record.gateway_ft_ch_kvm26_aaaa_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_lv_kvm28_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "209.141.55.108"
}

moved {
  from = cloudflare_record.gateway_ft_lv_kvm28_a_lsferreira
  to   = cloudflare_dns_record.gateway_ft_lv_kvm28_a_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_lv_kvm28_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:20:1051:3856::1"
}

moved {
  from = cloudflare_record.gateway_ft_lv_kvm28_aaaa_lsferreira
  to   = cloudflare_dns_record.gateway_ft_lv_kvm28_aaaa_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_ny_kvm21_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "198.98.62.203"
}

moved {
  from = cloudflare_record.gateway_ft_ny_kvm21_a_lsferreira
  to   = cloudflare_dns_record.gateway_ft_ny_kvm21_a_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_ny_kvm21_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:10:36e:635d::1"
}

moved {
  from = cloudflare_record.gateway_ft_ny_kvm21_aaaa_lsferreira
  to   = cloudflare_dns_record.gateway_ft_ny_kvm21_aaaa_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_mia_kvm11_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "45.61.188.200"
}

moved {
  from = cloudflare_record.gateway_ft_mia_kvm11_a_lsferreira
  to   = cloudflare_dns_record.gateway_ft_mia_kvm11_a_lsferreira
}

resource "cloudflare_dns_record" "gateway_ft_mia_kvm11_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:40:fef2:b133::1"
}

moved {
  from = cloudflare_record.gateway_ft_mia_kvm11_aaaa_lsferreira
  to   = cloudflare_dns_record.gateway_ft_mia_kvm11_aaaa_lsferreira
}

resource "cloudflare_dns_record" "gateway_dh_d_ams_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "92.112.125.156"
}

moved {
  from = cloudflare_record.gateway_dh_d_ams_01_a_lsferreira
  to   = cloudflare_dns_record.gateway_dh_d_ams_01_a_lsferreira
}

resource "cloudflare_dns_record" "gateway_dh_d_ams_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "gateway.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a12:bec4:1822:52::a"
}

moved {
  from = cloudflare_record.gateway_dh_d_ams_01_aaaa_lsferreira
  to   = cloudflare_dns_record.gateway_dh_d_ams_01_aaaa_lsferreira
}

resource "cloudflare_dns_record" "nc_anx04_1_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "nc-anx04-1.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "152.53.18.215"
}

moved {
  from = cloudflare_record.nc_anx04_1_a_lsferreira
  to   = cloudflare_dns_record.nc_anx04_1_a_lsferreira
}

resource "cloudflare_dns_record" "nc_anx04_1_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "nc-anx04-1.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a0a:4cc0:1:1111::1"
}

moved {
  from = cloudflare_record.nc_anx04_1_aaaa_lsferreira
  to   = cloudflare_dns_record.nc_anx04_1_aaaa_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-01.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "85.208.9.230"
}

moved {
  from = cloudflare_record.dh_o_ams_01_a_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_01_a_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-01.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a12:bec4:1821:15e::a"
}

moved {
  from = cloudflare_record.dh_o_ams_01_aaaa_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_01_aaaa_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_02_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-02.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "85.208.9.229"
}

moved {
  from = cloudflare_record.dh_o_ams_02_a_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_02_a_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_02_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-02.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a12:bec4:1821:15f::a"
}

moved {
  from = cloudflare_record.dh_o_ams_02_aaaa_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_02_aaaa_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_03_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-03.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "151.243.213.17"
}

moved {
  from = cloudflare_record.dh_o_ams_03_a_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_03_a_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_03_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-03.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a12:bec4:1821:177::a"
}

moved {
  from = cloudflare_record.dh_o_ams_03_aaaa_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_03_aaaa_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_04_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-04.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "151.243.213.18"
}

moved {
  from = cloudflare_record.dh_o_ams_04_a_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_04_a_lsferreira
}

resource "cloudflare_dns_record" "dh_o_ams_04_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-o-ams-04.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a12:bec4:1821:178::a"
}

moved {
  from = cloudflare_record.dh_o_ams_04_aaaa_lsferreira
  to   = cloudflare_dns_record.dh_o_ams_04_aaaa_lsferreira
}

resource "cloudflare_dns_record" "ft_ch_kvm26_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-ch-kvm26.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "107.189.6.72"
}

moved {
  from = cloudflare_record.ft_ch_kvm26_a_lsferreira
  to   = cloudflare_dns_record.ft_ch_kvm26_a_lsferreira
}

resource "cloudflare_dns_record" "ft_ch_kvm26_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-ch-kvm26.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:30:f891:e42b::1"
}

moved {
  from = cloudflare_record.ft_ch_kvm26_aaaa_lsferreira
  to   = cloudflare_dns_record.ft_ch_kvm26_aaaa_lsferreira
}

resource "cloudflare_dns_record" "ft_lv_kvm28_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-lv-kvm28.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "209.141.55.108"
}

moved {
  from = cloudflare_record.ft_lv_kvm28_a_lsferreira
  to   = cloudflare_dns_record.ft_lv_kvm28_a_lsferreira
}

resource "cloudflare_dns_record" "ft_lv_kvm28_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-lv-kvm28.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:20:1051:3856::1"
}

moved {
  from = cloudflare_record.ft_lv_kvm28_aaaa_lsferreira
  to   = cloudflare_dns_record.ft_lv_kvm28_aaaa_lsferreira
}

resource "cloudflare_dns_record" "ft_ny_kvm21_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-ny-kvm21.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "198.98.62.203"
}

moved {
  from = cloudflare_record.ft_ny_kvm21_a_lsferreira
  to   = cloudflare_dns_record.ft_ny_kvm21_a_lsferreira
}

resource "cloudflare_dns_record" "ft_ny_kvm21_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-ny-kvm21.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:10:36e:635d::1"
}

moved {
  from = cloudflare_record.ft_ny_kvm21_aaaa_lsferreira
  to   = cloudflare_dns_record.ft_ny_kvm21_aaaa_lsferreira
}

resource "cloudflare_dns_record" "ft_mia_kvm11_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-mia-kvm11.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "45.61.188.200"
}

moved {
  from = cloudflare_record.ft_mia_kvm11_a_lsferreira
  to   = cloudflare_dns_record.ft_mia_kvm11_a_lsferreira
}

resource "cloudflare_dns_record" "ft_mia_kvm11_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "ft-mia-kvm11.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2605:6400:40:fef2:b133::1"
}

moved {
  from = cloudflare_record.ft_mia_kvm11_aaaa_lsferreira
  to   = cloudflare_dns_record.ft_mia_kvm11_aaaa_lsferreira
}

resource "cloudflare_dns_record" "dh_d_ams_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-d-ams-01.internal.lsferreira.net"
  type    = "A"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "92.112.125.156"
}

moved {
  from = cloudflare_record.dh_d_ams_01_a_lsferreira
  to   = cloudflare_dns_record.dh_d_ams_01_a_lsferreira
}

resource "cloudflare_dns_record" "dh_d_ams_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "dh-d-ams-01.internal.lsferreira.net"
  type    = "AAAA"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "2a12:bec4:1822:52::a"
}

moved {
  from = cloudflare_record.dh_d_ams_01_aaaa_lsferreira
  to   = cloudflare_dns_record.dh_d_ams_01_aaaa_lsferreira
}

resource "cloudflare_dns_record" "ft_s_lu_04_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.result[0].id
  name    = "nmc-s-lu-04.internal.lsferreira.net"
  type    = "CNAME"
  proxied = false

  comment = "terraform"
  ttl     = 1
  content = "lu-shared04.cpanelplatform.com"
}
moved {
  from = cloudflare_record.ft_s_lu_04_cname_lsferreira
  to   = cloudflare_dns_record.ft_s_lu_04_cname_lsferreira
}
