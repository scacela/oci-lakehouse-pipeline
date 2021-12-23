resource "oci_dataintegration_workspace" "odi_workspace" {
    depends_on = [oci_identity_policy.odi_policy]
    #Required
    compartment_id = var.compartment_id
    display_name = var.odi_workspace_display_name

    #Optional
    is_private_network_enabled = var.workspace_is_private_network_enabled
    subnet_id = var.workspace_is_private_network_enabled ? oci_core_subnet.odi_subnet[0].id : null
    vcn_id = var.workspace_is_private_network_enabled ? var.vcn_id : null
}

resource "oci_core_subnet" "odi_subnet" {
  count = var.workspace_is_private_network_enabled ? 1 : 0

  cidr_block        = var.odi_subnet_cidr
  display_name      = var.odi_subnet_display_name
  compartment_id    = var.compartment_id
  vcn_id            = var.vcn_id
  dhcp_options_id   = var.vcn_default_dhcp_options_id
  route_table_id    = oci_core_route_table.odi_rt[0].id
  security_list_ids = [oci_core_security_list.odi_sl[0].id]
  prohibit_public_ip_on_vnic = true
  dns_label         = var.odi_subnet_dns_label
}

resource "oci_core_route_table" "odi_rt" {
  count = var.workspace_is_private_network_enabled ? 1 : 0
  
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.odi_rt_display_name
  route_rules {
    destination       = var.service_cidr_block
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = var.sg_id
  }
  route_rules {
    destination        = "0.0.0.0/0"
    network_entity_id = var.ng_id
  }
}

resource "oci_core_security_list" "odi_sl" {
  count = var.workspace_is_private_network_enabled ? 1 : 0

  compartment_id = var.compartment_id
  display_name   = var.odi_sl_display_name
  vcn_id         = var.vcn_id

  egress_security_rules {
    protocol    = "ALL"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "ALL"
    source   = "0.0.0.0/0"
  }
}

resource "oci_identity_group" "odi_group" {
  count = var.odi_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.odi_group_description
  name = var.odi_group_name
}

# resource "oci_identity_user_group_membership" "odi_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.odi_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_dynamic_group" "odi_dynamic_group" {
  count = var.odi_dynamic_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.odi_dynamic_group_description
  matching_rule = "Any {disworkspace.compartment.id='${var.compartment_id}'}"
  name = var.odi_dynamic_group_name
}

resource "oci_identity_policy" "odi_policy" {
  count = var.odi_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.odi_group, oci_identity_dynamic_group.odi_dynamic_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.odi_policy_description
  name = var.odi_policy_name
  statements = ["allow dynamic-group ${var.odi_dynamic_group_name} to manage buckets in ${var.compartment_policy_statement_substring} where ALL {request.permission = 'PAR_MANAGE'}",
  "allow dynamic-group ${var.odi_dynamic_group_name} to manage dataflow-application in ${var.compartment_policy_statement_substring}",
  "allow dynamic-group ${var.odi_dynamic_group_name} to manage objects in ${var.compartment_policy_statement_substring}",    
  "allow dynamic-group ${var.odi_dynamic_group_name} to use buckets in ${var.compartment_policy_statement_substring}",
  "allow group ${var.odi_group_name} to manage dataflow-run in ${var.compartment_policy_statement_substring}",
  "allow group ${var.odi_group_name} to manage dis-family in ${var.compartment_policy_statement_substring}",
  "allow group ${var.odi_group_name} to manage virtual-network-family in ${var.compartment_policy_statement_substring}",
  "allow group ${var.odi_group_name} to read autonomous-database-family in ${var.compartment_policy_statement_substring}",
  "allow group ${var.odi_group_name} to read dataflow-application in ${var.compartment_policy_statement_substring}",
  "allow group ${var.odi_group_name} to use object-family in ${var.compartment_policy_statement_substring}",
  "allow service dataintegration to use virtual-network-family in ${var.compartment_policy_statement_substring}"]
}