locals {
  ods_policy_statements_group = var.ods_group_is_deployed ? ["Allow group ${var.ods_group_name} to manage api-gateway-family in ${var.compartment_policy_statement_substring}",
  "Allow group ${var.ods_group_name} to manage data-science-family in ${var.compartment_policy_statement_substring}",
  "Allow group ${var.ods_group_name} to manage functions-family in ${var.compartment_policy_statement_substring}",
  "Allow group ${var.ods_group_name} to manage object-family in ${var.compartment_policy_statement_substring}",
  "Allow group ${var.ods_group_name} to manage repos in tenancy",
  "Allow group ${var.ods_group_name} to use autonomous-database-family in ${var.compartment_policy_statement_substring}",
  "Allow group ${var.ods_group_name} to use virtual-network-family in ${var.compartment_policy_statement_substring}"] : []
  
  ods_policy_statements_dynamic_group = var.ods_dynamic_group_is_deployed ? ["Allow dynamic-group ${var.ods_dynamic_group_name} to manage data-science-family in ${var.compartment_policy_statement_substring}",
  "Allow dynamic-group ${var.ods_dynamic_group_name} to manage object-family in ${var.compartment_policy_statement_substring}",
  "Allow dynamic-group ${var.ods_dynamic_group_name} to manage public-ips in ${var.compartment_policy_statement_substring}",
  "Allow dynamic-group ${var.ods_dynamic_group_name} to use autonomous-database-family in ${var.compartment_policy_statement_substring}",
  "Allow dynamic-group ${var.ods_dynamic_group_name} to use functions-family in ${var.compartment_policy_statement_substring}",
  "Allow dynamic-group ${var.ods_dynamic_group_name} to use virtual-network-family in ${var.compartment_policy_statement_substring}"] : []
  
  ods_policy_statements_service = ["Allow service datascience to use virtual-network-family in ${var.compartment_policy_statement_substring}",
  "Allow service FaaS to read repos in tenancy",
  "Allow service FaaS to use virtual-network-family in ${var.compartment_policy_statement_substring}"]

  ods_policy_statements = flatten([local.ods_policy_statements_group, local.ods_policy_statements_dynamic_group, local.ods_policy_statements_service])
}