resource "oci_core_vcn" "vcn" {
  cidr_blocks     = var.vcn_cidrs
  compartment_id = var.compartment_id
  display_name   = var.vcn_display_name
  dns_label      = var.vcn_dns_label
}

# Create NAT gateway to allow one way outbound internet traffic
resource "oci_core_nat_gateway" "ng" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = var.ng_display_name
}

# Create Service gateway to allow database server access to object storage bucket for backups
resource "oci_core_service_gateway" "sg" {
  compartment_id = var.compartment_id
  services {
    service_id = var.service_id
  }
  display_name   = var.sg_display_name
  vcn_id         = oci_core_vcn.vcn.id
}

resource "oci_identity_group" "vcn_group" {
  count = var.vcn_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.vcn_group_description
  name = var.vcn_group_name
}

# resource "oci_identity_user_group_membership" "vcn_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.vcn_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_policy" "vcn_policy" {
  count = var.vcn_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.vcn_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.vcn_policy_description
  name = var.vcn_policy_name
  statements = ["Allow group ${var.vcn_group_name} to manage vcns in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage subnets in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage route-tables in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage network-security-groups in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage security-lists in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage dhcp-options in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage private-ips in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage public-ips in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage ipv6s in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage internet-gateways in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage nat-gateways in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage service-gateways in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage local-peering-gateways in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage remote-peering-connections in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage drg-object in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage drg-attachments in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage drg-route-tables in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage drg-route-distributions in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage cpes in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage ipsec-connections in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage cross-connects in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage cross-connect-groups in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage virtual-circuits in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage vnics in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage vnic-attachments in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage vlans in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage byoiprange in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage publicippool in ${var.compartment_policy_statement_substring}",
# Aggregate resource-type
"Allow group ${var.vcn_group_name} to manage virtual-network-family in ${var.compartment_policy_statement_substring}",
"Allow group ${var.vcn_group_name} to manage drgs in ${var.compartment_policy_statement_substring}"]
}