resource "oci_datascience_project" "ods_project" {
    depends_on = [oci_identity_policy.ods_policy]
    #Required
    compartment_id = var.compartment_id
    #Optional
    display_name = var.project_display_name
}

resource "oci_datascience_notebook_session" "ods_notebook_session" {
    #Required
    compartment_id = var.compartment_id
    notebook_session_configuration_details {
        #Required
        shape = var.notebook_session_notebook_session_configuration_details_shape
        subnet_id = oci_core_subnet.ods_subnet.id

        #Optional
        block_storage_size_in_gbs = var.notebook_session_notebook_session_configuration_details_block_storage_size_in_gbs
    }
    project_id = oci_datascience_project.ods_project.id
    display_name = var.notebook_session_display_name
}

resource "oci_core_subnet" "ods_subnet" {
  cidr_block        = var.ods_subnet_cidr
  display_name      = var.ods_subnet_display_name
  compartment_id    = var.compartment_id
  vcn_id            = var.vcn_id
  dhcp_options_id   = var.vcn_default_dhcp_options_id
  route_table_id    = oci_core_route_table.ods_rt.id
  security_list_ids = [oci_core_security_list.ods_sl.id]
  prohibit_public_ip_on_vnic = true
  dns_label         = var.ods_subnet_dns_label
}

resource "oci_core_route_table" "ods_rt" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.ods_rt_display_name
  route_rules {
    destination       = var.service_cidr_block
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = var.sg_id
  }
  route_rules {
      network_entity_id = var.ng_id
      destination       = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "ods_sl" {
  compartment_id = var.compartment_id
  display_name   = var.ods_sl_display_name
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

resource "oci_identity_group" "ods_group" {
  count = var.ods_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.ods_group_description
  name = var.ods_group_name
}

# resource "oci_identity_user_group_membership" "ods_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.ods_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_dynamic_group" "ods_dynamic_group" {
  count = var.ods_dynamic_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.ods_dynamic_group_description
  matching_rule = "Any {fnfunc.compartment.id='${var.compartment_id}', ApiGateway.compartment.id='${var.compartment_id}', datasciencemodeldeployment.compartment.id='${var.compartment_id}', datasciencejobrun.compartment.id='${var.compartment_id}', datasciencenotebooksession.compartment.id='${var.compartment_id}'}"
  name = var.ods_dynamic_group_name
}

resource "oci_identity_policy" "ods_policy" {
  count = var.ods_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.ods_group, oci_identity_dynamic_group.ods_dynamic_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.ods_policy_description
  name = var.ods_policy_name
  statements = local.ods_policy_statements
}