module "compartment" {
  count = var.compartment_is_deployed ? 1 : 0
  source = "./modules/compartment"
  # configuration
  compartment_description = var.compartment_description
  compartment_name = local.compartment_name
  parent_compartment_id = local.parent_compartment_id
  enable_delete = var.enable_delete
  compartment_group_is_deployed = var.compartment_group_is_deployed
  compartment_group_name = local.compartment_group_name
  compartment_group_description = var.compartment_group_description
  compartment_dynamic_group_is_deployed = var.compartment_dynamic_group_is_deployed
  compartment_dynamic_group_name = local.compartment_dynamic_group_name
  compartment_dynamic_group_description = var.compartment_dynamic_group_description
  compartment_policy_is_deployed = var.compartment_policy_is_deployed
  compartment_policy_name = local.compartment_policy_name
  compartment_policy_description = var.compartment_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "vcn" {
  count = var.vcn_is_deployed ? 1 : 0
  source = "./modules/vcn"
  # configuration
  vcn_display_name = local.vcn_display_name
  vcn_dns_label = local.vcn_dns_label
  ng_display_name = local.ng_display_name
  sg_display_name = local.sg_display_name
  vcn_cidrs = var.vcn_cidrs
  compartment_id = local.compartment_id
  service_id = data.oci_core_services.services.services.0.id
  vcn_group_is_deployed = var.vcn_group_is_deployed
  vcn_group_name = local.vcn_group_name
  vcn_group_description = var.vcn_group_description
  vcn_dynamic_group_is_deployed = var.vcn_dynamic_group_is_deployed
  vcn_dynamic_group_name = local.vcn_dynamic_group_name
  vcn_dynamic_group_description = var.vcn_dynamic_group_description
  vcn_policy_is_deployed = var.vcn_policy_is_deployed
  vcn_policy_name = local.vcn_policy_name
  vcn_policy_description = var.vcn_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "ods" {
  depends_on = [module.vcn]
  count = var.vcn_is_deployed && var.ods_is_deployed ? 1 : 0
  source = "./modules/ods"
  # configuration
  project_display_name = local.project_display_name
  notebook_session_display_name = local.notebook_session_display_name
  notebook_session_notebook_session_configuration_details_shape = var.notebook_session_notebook_session_configuration_details_shape
  notebook_session_notebook_session_configuration_details_block_storage_size_in_gbs = var.notebook_session_notebook_session_configuration_details_block_storage_size_in_gbs
  ods_rt_display_name = local.ods_rt_display_name
  ods_sl_display_name = local.ods_sl_display_name
  ods_subnet_display_name = local.ods_subnet_display_name
  ods_subnet_dns_label = local.ods_subnet_dns_label
  ods_subnet_cidr = var.ods_subnet_cidr
  compartment_id = local.compartment_id
  vcn_id = module.vcn[0].vcn_id
  vcn_default_dhcp_options_id = module.vcn[0].vcn_default_dhcp_options_id
  ng_id = module.vcn[0].ng_id
  sg_id = module.vcn[0].sg_id
  service_cidr_block = data.oci_core_services.services.services.0.cidr_block
  tenancy_ocid = var.tenancy_ocid
  user_ocid = local.user_ocid
  ods_group_is_deployed = var.ods_group_is_deployed
  ods_group_name = local.ods_group_name
  ods_group_description = var.ods_group_description
  ods_dynamic_group_is_deployed = var.ods_dynamic_group_is_deployed
  ods_dynamic_group_name = local.ods_dynamic_group_name
  ods_dynamic_group_description = var.ods_dynamic_group_description
  ods_policy_is_deployed = var.ods_policy_is_deployed
  ods_policy_name = local.ods_policy_name
  ods_policy_description = var.ods_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "odi" {
  depends_on = [module.vcn]
  count = var.odi_is_deployed ? 1 : 0
  source = "./modules/odi"
  # configuration
  odi_workspace_display_name = local.odi_workspace_display_name
  workspace_is_private_network_enabled = local.workspace_is_private_network_enabled
  odi_rt_display_name = local.odi_rt_display_name
  odi_sl_display_name = local.odi_sl_display_name
  odi_subnet_display_name = local.odi_subnet_display_name
  odi_subnet_dns_label = local.odi_subnet_dns_label
  odi_subnet_cidr = var.odi_subnet_cidr
  compartment_id = local.compartment_id
  vcn_id = module.vcn[0].vcn_id
  vcn_default_dhcp_options_id = module.vcn[0].vcn_default_dhcp_options_id
  ng_id = module.vcn[0].ng_id
  sg_id = module.vcn[0].sg_id
  service_cidr_block = data.oci_core_services.services.services.0.cidr_block
  tenancy_ocid = var.tenancy_ocid
  user_ocid = local.user_ocid
  odi_group_is_deployed = var.odi_group_is_deployed
  odi_group_name = local.odi_group_name
  odi_group_description = var.odi_group_description
  odi_dynamic_group_is_deployed = var.odi_dynamic_group_is_deployed
  odi_dynamic_group_name = local.odi_dynamic_group_name
  odi_dynamic_group_description = var.odi_dynamic_group_description
  odi_policy_is_deployed = var.odi_policy_is_deployed
  odi_policy_name = local.odi_policy_name
  odi_policy_description = var.odi_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "adw" {
  count = var.adw_is_deployed ? 1 : 0
  source = "./modules/adw"
  # configuration
  autonomous_database_admin_password = var.autonomous_database_admin_password
  autonomous_database_cpu_core_count = var.autonomous_database_cpu_core_count
  autonomous_database_db_version = var.autonomous_database_db_version
  autonomous_database_is_auto_scaling_enabled = var.autonomous_database_is_auto_scaling_enabled
  autonomous_database_data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
  autonomous_database_display_name = local.autonomous_database_display_name
  autonomous_database_db_name = local.autonomous_database_db_name
  autonomous_database_db_workload = var.autonomous_database_db_workload
  autonomous_database_license_model = var.autonomous_database_license_model
  autonomous_database_data_safe_status = var.autonomous_database_data_safe_status
  autonomous_database_whitelisted_ips = var.autonomous_database_whitelisted_ips
  compartment_id = local.compartment_id
  adw_group_is_deployed = var.adw_group_is_deployed
  adw_group_name = local.adw_group_name
  adw_group_description = var.adw_group_description
  adw_dynamic_group_is_deployed = var.adw_dynamic_group_is_deployed
  adw_dynamic_group_name = local.adw_dynamic_group_name
  adw_dynamic_group_description = var.adw_dynamic_group_description
  adw_policy_is_deployed = var.adw_policy_is_deployed
  adw_policy_name = local.adw_policy_name
  adw_policy_description = var.adw_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "oac" {
  count = var.oac_is_deployed ? 1 : 0
  source = "./modules/oac"
  # configuration
  analytics_instance_name = local.analytics_instance_name
  analytics_instance_capacity_capacity_type = var.analytics_instance_capacity_capacity_type
  analytics_instance_capacity_capacity_value = var.analytics_instance_capacity_capacity_value
  analytics_instance_feature_set = var.analytics_instance_feature_set
  analytics_instance_license_type = var.analytics_instance_license_type
  compartment_id = local.compartment_id
  analytics_instance_idcs_access_token = var.analytics_instance_idcs_access_token
  oac_group_is_deployed = var.oac_group_is_deployed
  oac_group_name = local.oac_group_name
  oac_group_description = var.oac_group_description
  oac_dynamic_group_is_deployed = var.oac_dynamic_group_is_deployed
  oac_dynamic_group_name = local.oac_dynamic_group_name
  oac_dynamic_group_description = var.oac_dynamic_group_description
  oac_policy_is_deployed = var.oac_policy_is_deployed
  oac_policy_name = local.oac_policy_name
  oac_policy_description = var.oac_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "bucket" {
  count = var.bucket_is_deployed ? 1 : 0
  source = "./modules/bucket"
  # configuration
  bucket_name = local.bucket_name
  bucket_access_type = var.bucket_access_type
  bucket_storage_tier = var.bucket_storage_tier
  bucket_versioning = var.bucket_versioning
  objectstorage_namespace = data.oci_objectstorage_namespace.namespace.namespace
  compartment_id = local.compartment_id
  bucket_group_is_deployed = var.bucket_group_is_deployed
  bucket_group_name = local.bucket_group_name
  bucket_group_description = var.bucket_group_description
  bucket_dynamic_group_is_deployed = var.bucket_dynamic_group_is_deployed
  bucket_dynamic_group_name = local.bucket_dynamic_group_name
  bucket_dynamic_group_description = var.bucket_dynamic_group_description
  bucket_policy_is_deployed = var.bucket_policy_is_deployed
  bucket_policy_name = local.bucket_policy_name
  bucket_policy_description = var.bucket_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "datacatalog" {
  count = var.datacatalog_is_deployed ? 1 : 0
  source = "./modules/datacatalog"
  # configuration
  datacatalog_display_name = local.datacatalog_display_name
  compartment_id = local.compartment_id
  datacatalog_group_is_deployed = var.datacatalog_group_is_deployed
  datacatalog_group_name = local.datacatalog_group_name
  datacatalog_group_description = var.datacatalog_group_description
  datacatalog_dynamic_group_is_deployed = var.datacatalog_dynamic_group_is_deployed
  datacatalog_dynamic_group_name = local.datacatalog_dynamic_group_name
  datacatalog_dynamic_group_description = var.datacatalog_dynamic_group_description
  datacatalog_policy_is_deployed = var.datacatalog_policy_is_deployed
  datacatalog_policy_name = local.datacatalog_policy_name
  datacatalog_policy_description = var.datacatalog_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}

module "streaming" {
  count = var.streaming_is_deployed ? 1 : 0
  source = "./modules/streaming"
  # configuration
  stream_name = local.stream_name
  stream_partitions = var.stream_partitions
  stream_retention_in_hours = var.stream_retention_in_hours
  stream_pool_name = local.stream_pool_name
  compartment_id = local.compartment_id
  streaming_group_is_deployed = var.streaming_group_is_deployed
  streaming_group_name = local.streaming_group_name
  streaming_group_description = var.streaming_group_description
  streaming_dynamic_group_is_deployed = var.streaming_dynamic_group_is_deployed
  streaming_dynamic_group_name = local.streaming_dynamic_group_name
  streaming_dynamic_group_description = var.streaming_dynamic_group_description
  streaming_policy_is_deployed = var.streaming_policy_is_deployed
  streaming_policy_name = local.streaming_policy_name
  streaming_policy_description = var.streaming_policy_description
  compartment_policy_statement_substring = local.compartment_policy_statement_substring
}