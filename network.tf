resource "oci_core_virtual_network" "tajVCN" {
  cidr_block = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name = "tajVCN"
  dns_label = "tajVCN"
}

resource "oci_core_subnet" "tajSN" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.20.0/24"
  display_name = "tajSN"
  dns_label = "tajSN"
  security_list_ids = ["${oci_core_virtual_network.tajVCN.default_security_list_id}"]
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tajVCN.id}"
  route_table_id = "${oci_core_route_table.tajRT.id}"
  dhcp_options_id = "${oci_core_virtual_network.tajVCN.default_dhcp_options_id}"
}

resource "oci_core_internet_gateway" "tajIG" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "tajIG"
  vcn_id = "${oci_core_virtual_network.tajVCN.id}"
}

resource "oci_core_route_table" "tajRT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tajVCN.id}"
  display_name = "tajRT"
  route_rules {
    cidr_block = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.tajIG.id}"
  }
}
