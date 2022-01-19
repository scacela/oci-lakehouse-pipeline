resource "oci_objectstorage_bucket" "bucket" {
    #Required
    compartment_id = var.compartment_id
    name = var.bucket_name
    namespace = var.objectstorage_namespace

    #Optional
    access_type = var.bucket_access_type
    storage_tier = var.bucket_storage_tier
    versioning = var.bucket_versioning
}

resource "oci_identity_group" "bucket_group" {
  count = var.bucket_group_is_deployed ? 1 : 0
  #Required
  compartment_id = var.tenancy_ocid
  description = var.bucket_group_description
  name = var.bucket_group_name
}

# resource "oci_identity_user_group_membership" "bucket_user_group_membership" {
#     #Required
#     group_id = oci_identity_group.bucket_group.id
#     user_id = var.user_ocid
# }

resource "oci_identity_policy" "bucket_policy" {
  count = var.bucket_policy_is_deployed ? 1 : 0
  depends_on = [oci_identity_group.bucket_group]
  #Required
  compartment_id = var.tenancy_ocid
  description = var.bucket_policy_description
  name = var.bucket_policy_name
  statements = ["Allow group ${var.bucket_group_name} to manage buckets in ${var.compartment_policy_statement_substring}",
  "Allow group ${var.bucket_group_name} to manage objects in ${var.compartment_policy_statement_substring}",
    # Aggregate resource-type
  "Allow group ${var.bucket_group_name} to manage object-family in ${var.compartment_policy_statement_substring}"]
}