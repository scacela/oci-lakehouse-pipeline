resource "oci_database_autonomous_database" "adw" {
    #Required
    compartment_id = var.compartment_id
    db_name = var.autonomous_database_db_name

    #Optional
    admin_password = var.autonomous_database_admin_password
    cpu_core_count = var.autonomous_database_cpu_core_count
    data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
    db_version = var.autonomous_database_db_version
    data_safe_status = var.autonomous_database_data_safe_status
    db_workload = var.autonomous_database_db_workload
    display_name = var.autonomous_database_display_name
    is_auto_scaling_enabled = var.autonomous_database_is_auto_scaling_enabled
    license_model = var.autonomous_database_license_model   
    whitelisted_ips = var.autonomous_database_whitelisted_ips
}

resource "oci_identity_group" "adw_group" {
  count = var.adw_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.adw_group_description
  name = var.adw_group_name
}

# resource "oci_identity_user_group_membership" "adw_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.adw_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_dynamic_group" "adw_dynamic_group" {
  count = var.adw_dynamic_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.adw_dynamic_group_description
  # matching_rule =
  name = var.adw_dynamic_group_name
}

resource "oci_identity_policy" "adw_policy" {
  count = var.adw_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.adw_group, oci_identity_dynamic_group.adw_dynamic_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.adw_policy_description
  name = var.adw_policy_name
  statements = ["Allow group ${var.adw_group_name} to manage autonomous-backups in ${var.compartment_policy_statement_substring}",
  "Allow group ${var.adw_group_name} to manage autonomous-databases in ${var.compartment_policy_statement_substring}",
  # Aggregate Resource-Type
  "Allow group ${var.adw_group_name} to manage autonomous-database-family in ${var.compartment_policy_statement_substring}"]
}