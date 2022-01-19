resource "oci_analytics_analytics_instance" "oac" {
    #Required
    compartment_id = var.compartment_id
    feature_set = var.analytics_instance_feature_set
    license_type = var.analytics_instance_license_type
    name = var.analytics_instance_name
    idcs_access_token = var.analytics_instance_idcs_access_token
    capacity {
        #Required
        capacity_type = var.analytics_instance_capacity_capacity_type
        capacity_value = var.analytics_instance_capacity_capacity_value
    }
}

resource "oci_identity_group" "oac_group" {
  count = var.oac_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.oac_group_description
  name = var.oac_group_name
}

# resource "oci_identity_user_group_membership" "oac_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.oac_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_policy" "oac_policy" {
  count = var.oac_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.oac_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.oac_policy_description
  name = var.oac_policy_name
  statements = ["Allow group ${var.oac_group_name} to manage analytics-instances in ${var.compartment_policy_statement_substring}",
"Allow group ${var.oac_group_name} to manage analytics-instance-work-requests in ${var.compartment_policy_statement_substring}"]
}