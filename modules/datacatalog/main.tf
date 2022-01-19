resource "oci_datacatalog_catalog" "catalog" {
    #Required
    compartment_id = var.compartment_id
    display_name = var.datacatalog_display_name
}

resource "oci_identity_group" "datacatalog_group" {
  count = var.datacatalog_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.datacatalog_group_description
  name = var.datacatalog_group_name
}

# resource "oci_identity_user_group_membership" "datacatalog_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.datacatalog_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_dynamic_group" "datacatalog_dynamic_group" {
  count = var.datacatalog_dynamic_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.datacatalog_dynamic_group_description
  matching_rule = "Any {datacatalog.compartment.id='${var.compartment_id}'}"
  name = var.datacatalog_dynamic_group_name
}

resource "oci_identity_policy" "datacatalog_policy" {
  count = var.datacatalog_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.datacatalog_group, oci_identity_dynamic_group.datacatalog_dynamic_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.datacatalog_policy_description
  name = var.datacatalog_policy_name
  statements = ["allow dynamic-group ${var.datacatalog_dynamic_group_name} to read object-family in ${var.compartment_policy_statement_substring}",
"Allow group ${var.datacatalog_group_name} to manage data-catalogs in ${var.compartment_policy_statement_substring}",
"Allow group ${var.datacatalog_group_name} to manage data-catalogs-private-endpoints in ${var.compartment_policy_statement_substring}",
"Allow group ${var.datacatalog_group_name} to manage data-catalog-metastores in ${var.compartment_policy_statement_substring}",
"Allow group ${var.datacatalog_group_name} to manage data-catalog-data-assets in ${var.compartment_policy_statement_substring}",
"Allow group ${var.datacatalog_group_name} to manage data-catalog-glossaries in ${var.compartment_policy_statement_substring}",
"Allow group ${var.datacatalog_group_name} to manage data-catalog-namespaces in ${var.compartment_policy_statement_substring}",
# Aggregate resource-type
"Allow group ${var.datacatalog_group_name} to manage data-catalog-family in ${var.compartment_policy_statement_substring}"]
}