locals {
  share_save_mgt_principal = "857624037201"
  share_save_ri_principal  = "727378841472"
  is_master_account        = data.aws_organizations_organization.current.master_account_id == data.aws_caller_identity.current.account_id
}
