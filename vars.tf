# Authentication
variable "tenancy_ocid" { default = "" }
variable "user_ocid" { default = "" }
variable "fingerprint" { default = "" }
variable "private_key_path" { default = "" }
variable "region" { default = "" }
variable "current_user_ocid" { default = "" } # current_user_ocid can be left unused for Terraform deployment. It is only used during Resource Manager deployment.

# Required Input
variable "analytics_instance_idcs_access_token" { default = "" }

# Naming
variable "suffix" { default = "DEFAULT_REGION_KEY" }

# Compartment
variable "compartment_is_deployed" { default = true }
variable "compartment_description" { default = "Compartment for Streaming Pipeline" }
variable "compartment_name" { default = "Streaming" }
variable "compartment_id" { default = "DEFAULT_TENANCY" }
variable "parent_compartment_id" { default = "DEFAULT_TENANCY" } # if compartment_is_deployed == true, then parent_compartment_id is used in the place of compartment_id
variable "enable_delete" { default = false }
variable "compartment_group_is_deployed" { default = true }
variable "compartment_group_name" { default = "CompartmentGroup" }
variable "compartment_group_description" { default = "Group for users who manage Compartment-related operations." }
variable "compartment_policy_is_deployed" { default = true }
variable "compartment_policy_name" { default = "CompartmentPolicy" }
variable "compartment_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# VCN
variable "vcn_is_deployed" { default = true }
variable "vcn_display_name" { default = "VCN" }
variable "vcn_dns_label" { default = "vcn" }
variable "ng_display_name" { default = "NAT Gateway" }
variable "sg_display_name" { default = "Service Gateway" }
variable "vcn_cidrs" {
  type = list(string)
  default = ["10.0.0.0/16"]
}
variable "vcn_group_is_deployed" { default = true }
variable "vcn_group_name" { default = "VirtualCloudNetworkGroup" }
variable "vcn_group_description" { default = "Group for users who manage Virtual-Cloud-Network-related operations." }
variable "vcn_policy_is_deployed" { default = true }
variable "vcn_policy_name" { default = "VirtualCloudNetworkPolicy" }
variable "vcn_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# ODS
variable "ods_is_deployed" { default = true }
variable "project_display_name" { default = "ODS Project" }
variable "notebook_session_display_name" { default = "Notebook Session" }
variable "notebook_session_notebook_session_configuration_details_shape" { default = "VM.Standard2.1" }
variable "notebook_session_notebook_session_configuration_details_block_storage_size_in_gbs" { default = 50 }
variable "ods_rt_display_name" { default = "ODS Route Table" }
variable "ods_sl_display_name" { default = "ODS Security List" }
variable "ods_subnet_display_name" { default = "ODS Subnet" }
variable "ods_subnet_dns_label" { default = "ods-sub" }
variable "ods_subnet_cidr" { default = "10.0.0.0/24" }
variable "ods_group_is_deployed" { default = true }
variable "ods_group_name" { default = "DataScienceGroup" }
variable "ods_group_description" { default = "Group for users who manage Data-Science-related operations." }
variable "ods_dynamic_group_is_deployed" { default = true }
variable "ods_dynamic_group_name" { default = "DataScienceDynamicGroup" }
variable "ods_dynamic_group_description" { default = "Group defined by a rule that matches particular resource-types within a given compartment." }
variable "ods_policy_is_deployed" { default = true }
variable "ods_policy_name" { default = "DataSciencePolicy" }
variable "ods_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# ODI
variable "odi_is_deployed" { default = true }
variable "odi_workspace_display_name" { default = "ODI Workspace" }
variable "workspace_is_private_network_enabled" { default = true }
variable "odi_rt_display_name" { default = "ODI Route Table" }
variable "odi_sl_display_name" { default = "ODI Security List" }
variable "odi_subnet_display_name" { default = "ODI Subnet" }
variable "odi_subnet_dns_label" { default = "odi-sub" }
variable "odi_subnet_cidr" { default = "10.0.1.0/24" }
variable "odi_group_is_deployed" { default = true }
variable "odi_group_name" { default = "DataIntegrationGroup" }
variable "odi_group_description" { default = "Group for users who manage Data-Integration-related operations." }
variable "odi_dynamic_group_is_deployed" { default = true }
variable "odi_dynamic_group_name" { default = "DataIntegrationDynamicGroup" }
variable "odi_dynamic_group_description" { default = "Group defined by a rule that matches particular resource-types within a given compartment." }
variable "odi_policy_is_deployed" { default = true }
variable "odi_policy_name" { default = "DataIntegrationPolicy" }
variable "odi_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# ADW
variable "adw_is_deployed" { default = true }
# The password must be between 12 and 30 characters long, and must contain at least 1 uppercase, 1 lowercase, and 1 numeric character. It cannot contain the double quote symbol (") or the username "admin", regardless of casing.
variable "autonomous_database_admin_password" {
  default = "Welcome!2345"
  sensitive = true
}
variable "autonomous_database_cpu_core_count" { default = 1 }
variable "autonomous_database_db_version" { default = "19c" }
variable "autonomous_database_is_auto_scaling_enabled" { default = false }
variable "autonomous_database_data_storage_size_in_tbs" { default = 1 }
variable "autonomous_database_display_name" { default = "ADW" }
variable "autonomous_database_db_name" { default = "adw" } # The name must begin with an alphabetic character and can contain a maximum of 14 alphanumeric characters. Special characters are not permitted. The database name must be unique in the tenancy.
variable "autonomous_database_db_workload" { default = "DW" }
variable "autonomous_database_license_model" { default = "LICENSE_INCLUDED" }
variable "autonomous_database_data_safe_status" { default = "NOT_REGISTERED" }
variable "autonomous_database_whitelisted_ips" {
  type = list(string)
  default = ["0.0.0.0/0"]
}
variable "adw_group_is_deployed" { default = true }
variable "adw_group_name" { default = "AutonomousDataWarehouseGroup" }
variable "adw_group_description" { default = "Group for users who manage Autonomous-Data-Warehouse-related operations." }
variable "adw_policy_is_deployed" { default = true }
variable "adw_policy_name" { default = "AutonomousDataWarehousePolicy" }
variable "adw_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# OAC
variable "oac_is_deployed" { default = true }
variable "analytics_instance_name" { default = "OAC" } # The name of the database within your OAC instance. The name must contain only letters and numbers, starting with a letter. Spaces are not allowed. The OAC instance name must be unique in the tenancy.
variable "analytics_instance_capacity_capacity_type" { default = "OLPU_COUNT" }
variable "analytics_instance_capacity_capacity_value" { default = 2 }
variable "analytics_instance_feature_set" { default = "ENTERPRISE_ANALYTICS" }
variable "analytics_instance_license_type" { default = "LICENSE_INCLUDED" }
variable "oac_group_is_deployed" { default = true }
variable "oac_group_name" { default = "AnalyticsCloudGroup" }
variable "oac_group_description" { default = "Group for users who manage Analytics-Cloud-related operations." }
variable "oac_policy_is_deployed" { default = true }
variable "oac_policy_name" { default = "AnalyticsCloudPolicy" }
variable "oac_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# Bucket
variable "bucket_is_deployed" { default = true }
variable "bucket_name" { default = "Bucket" }
variable "bucket_access_type" { default = "NoPublicAccess" }
variable "bucket_storage_tier" { default = "Standard" }
variable "bucket_versioning" { default = "Disabled" }
variable "bucket_group_is_deployed" { default = true }
variable "bucket_group_name" { default = "BucketGroup" }
variable "bucket_group_description" { default = "Group for users who manage Bucket-related operations." }
variable "bucket_policy_is_deployed" { default = true }
variable "bucket_policy_name" { default = "BucketPolicy" }
variable "bucket_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# Data Catalog
variable "datacatalog_is_deployed" { default = true }
variable "datacatalog_display_name" { default = "Data Catalog" }
variable "datacatalog_group_is_deployed" { default = true }
variable "datacatalog_group_name" { default = "DataCatalogGroup" }
variable "datacatalog_group_description" { default = "Group for users who manage Data-Catalog-related operations." }
variable "datacatalog_dynamic_group_is_deployed" { default = true }
variable "datacatalog_dynamic_group_name" { default = "DataCatalogDynamicGroup" }
variable "datacatalog_dynamic_group_description" { default = "Group defined by a rule that matches particular resource-types within a given compartment." }
variable "datacatalog_policy_is_deployed" { default = true }
variable "datacatalog_policy_name" { default = "DataCatalogPolicy" }
variable "datacatalog_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }

# Streaming
variable "streaming_is_deployed" { default = true }
variable "stream_name" { default = "Stream" }
variable "stream_partitions" { default = 1 }
variable "stream_retention_in_hours" { default = 24 }
variable "stream_pool_name" { default = "Stream Pool" }
variable "streaming_group_is_deployed" { default = true }
variable "streaming_group_name" { default = "StreamingGroup" }
variable "streaming_group_description" { default = "Group for users who manage Streaming-related operations." }
variable "streaming_policy_is_deployed" { default = true }
variable "streaming_policy_name" { default = "StreamingPolicy" }
variable "streaming_policy_description" { default = "Collection of policy statements that grant permissions for user groups, dynamic groups, and services." }