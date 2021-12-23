output "adw_id" {
  value = var.adw_is_deployed ? module.adw[0].adw_id : null
}
output "bucket_id" {
  value = var.bucket_is_deployed ? module.bucket[0].bucket_id : null
}
output "compartment_id" {
  value = local.compartment_id
}
output "datacatalog_id" {
  value = var.datacatalog_is_deployed ? module.datacatalog[0].datacatalog_id : null
}
output "oac_id" {
  value = var.oac_is_deployed ? module.oac[0].oac_id : null
}
output "odi_workspace_id" {
  value = var.odi_is_deployed ? module.odi[0].odi_workspace_id : null
}
output "ods_notebook_session_id" {
  value = var.ods_is_deployed ? module.ods[0].ods_notebook_session_id : null
}
output "stream_pool_id" {
  value = var.streaming_is_deployed ? module.streaming[0].stream_pool_id : null
}
output "stream_id" {
  value = var.streaming_is_deployed ? module.streaming[0].stream_id : null
}
output "vcn_id" {
  value = var.vcn_is_deployed ? module.vcn[0].vcn_id : null
}