#dev terragrunt file
include "root" {
  path = find_in_parent_folders()
}
