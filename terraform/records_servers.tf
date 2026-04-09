resource "cloudflare_record" "master_k3s_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "master.k3s.internal.lsferreira.net"
  value = "nc-anx04-1.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "master_k8s_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "master.k8s.internal.lsferreira.net"
  value = "master.k3s.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

# =============================================================================
# GATEWAY ALIAS RECORDS
# =============================================================================

resource "cloudflare_record" "geo_gateway_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "geo.gateway.lsferreira.net"
  value = "198.251.90.61"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "nl_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "nl.gateway.lsferreira.net"
  value = "dh-d-ams-01.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "au_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "au.gateway.lsferreira.net"
  value = "nc-anx04-1.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ch_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ch.gateway.lsferreira.net"
  value = "ft-ch-kvm26.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "us1_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-lv-kvm28.internal.lsferreira.net"
  value = "209.141.55.108"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "us2_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "us2.gateway.lsferreira.net"
  value = "uft-ny-kvm21.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "us3_gateway_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "us3.gateway.lsferreira.net"
  value = "ft-mia-kvm11.internal.lsferreira.net"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}

# =============================================================================
# GATEWAY RECORD
# =============================================================================

resource "cloudflare_record" "gateway_geo_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "198.251.90.61"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_nc_anx04_1_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "152.53.18.215"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_nc_anx04_1_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "2a0a:4cc0:1:1111::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_ch_kvm26_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "107.189.6.72"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_ch_kvm26_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "2605:6400:30:f891:e42b::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_lv_kvm28_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "209.141.55.108"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_lv_kvm28_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "2605:6400:20:1051:3856::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_ny_kvm21_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "198.98.62.203"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_ny_kvm21_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "2605:6400:10:36e:635d::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_mia_kvm11_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "45.61.188.200"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_ft_mia_kvm11_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "2605:6400:40:fef2:b133::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_dh_d_ams_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "92.112.125.156"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "gateway_dh_d_ams_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "gateway.lsferreira.net"
  value = "2a12:bec4:1822:52::a"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

# =============================================================================
# SERVER RECORDS
# =============================================================================

resource "cloudflare_record" "nc_anx04_1_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "nc-anx04-1.internal.lsferreira.net"
  value = "152.53.18.215"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "nc_anx04_1_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "nc-anx04-1.internal.lsferreira.net"
  value = "2a0a:4cc0:1:1111::1"
  type = "AAAA"
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

resource "cloudflare_record" "dh_o_ams_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-01.internal.lsferreira.net"
  value = "2a12:bec4:1821:15e::a"
  type = "AAAA"
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

resource "cloudflare_record" "dh_o_ams_02_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-02.internal.lsferreira.net"
  value = "2a12:bec4:1821:15f::a"
  type = "AAAA"
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

resource "cloudflare_record" "dh_o_ams_03_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-03.internal.lsferreira.net"
  value = "2a12:bec4:1821:177::a"
  type = "AAAA"
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

resource "cloudflare_record" "dh_o_ams_04_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-o-ams-04.internal.lsferreira.net"
  value = "2a12:bec4:1821:178::a"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_ch_kvm26_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-ch-kvm26.internal.lsferreira.net"
  value = "107.189.6.72"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_ch_kvm26_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-ch-kvm26.internal.lsferreira.net"
  value = "2605:6400:30:f891:e42b::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_lv_kvm28_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-lv-kvm28.internal.lsferreira.net"
  value = "209.141.55.108"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_lv_kvm28_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-lv-kvm28.internal.lsferreira.net"
  value = "2605:6400:20:1051:3856::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_ny_kvm21_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-ny-kvm21.internal.lsferreira.net"
  value = "198.98.62.203"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_ny_kvm21_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-ny-kvm21.internal.lsferreira.net"
  value = "2605:6400:10:36e:635d::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_mia_kvm11_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-mia-kvm11.internal.lsferreira.net"
  value = "45.61.188.200"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_mia_kvm11_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "ft-mia-kvm11.internal.lsferreira.net"
  value = "2605:6400:40:fef2:b133::1"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_d_ams_01_a_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-d-ams-01.internal.lsferreira.net"
  value = "92.112.125.156"
  type = "A"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "dh_d_ams_01_aaaa_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "dh-d-ams-01.internal.lsferreira.net"
  value = "2a12:bec4:1822:52::a"
  type = "AAAA"
  proxied = false

  comment = "terraform"
}

resource "cloudflare_record" "ft_s_lu_04_cname_lsferreira" {
  zone_id = data.cloudflare_zones.lsferreira_net.zones[0].id
  name = "nmc-s-lu-04.internal.lsferreira.net"
  value = "lu-shared04.cpanelplatform.com"
  type = "CNAME"
  proxied = false

  comment = "terraform"
}