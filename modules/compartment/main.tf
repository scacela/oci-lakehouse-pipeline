resource "oci_identity_compartment" "compartment" {
    #Required
    compartment_id = var.parent_compartment_id
    description = var.compartment_description
    name = var.compartment_name
    enable_delete = var.enable_delete
}

resource "oci_identity_group" "compartment_group" {
  count = var.compartment_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.compartment_group_description
  name = var.compartment_group_name
}

# resource "oci_identity_user_group_membership" "compartment_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.compartment_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_policy" "compartment_policy" {
  count = var.compartment_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.compartment_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.compartment_policy_description
  name = var.compartment_policy_name
  statements = ["Allow group ${var.compartment_group_name} to manage all-resources in ${var.compartment_policy_statement_substring}"]
}