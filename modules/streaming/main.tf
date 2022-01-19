resource "oci_streaming_stream_pool" "stream_pool" {
   #Required
   compartment_id = var.compartment_id
   name = var.stream_pool_name
}
resource "oci_streaming_stream" "stream" {
   #Required
   name = var.stream_name
   partitions = var.stream_partitions
   retention_in_hours = var.stream_retention_in_hours
   stream_pool_id = oci_streaming_stream_pool.stream_pool.id
}

resource "oci_identity_group" "streaming_group" {
  count = var.streaming_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.streaming_group_description
  name = var.streaming_group_name
}

# resource "oci_identity_user_group_membership" "streaming_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.streaming_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_policy" "streaming_policy" {
  count = var.streaming_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.streaming_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.streaming_policy_description
  name = var.streaming_policy_name
  statements = ["Allow group ${var.streaming_group_name} to manage streams in ${var.compartment_policy_statement_substring}",
"Allow group ${var.streaming_group_name} to manage stream-pull in ${var.compartment_policy_statement_substring}",
"Allow group ${var.streaming_group_name} to manage stream-push in ${var.compartment_policy_statement_substring}",
"Allow group ${var.streaming_group_name} to manage stream-harness in ${var.compartment_policy_statement_substring}",
"Allow group ${var.streaming_group_name} to manage stream-pools in ${var.compartment_policy_statement_substring}"]
}