output "cur_bucket_arn" {
  description = "The ARN of the CUR S3 bucket"
  value       = local.is_master_account ? aws_s3_bucket.nops_cur_bucket[0].arn : ""
}

output "nops_sharesave_mgt_role_arn" {
  description = "The ARN of the Sharesave Management role"
  value       = !local.is_master_account ? aws_iam_role.nops_share_save_mgt_role[0].arn : ""
}

output "nops_sharesave_ri_role_arn" {
  description = "The ARN of the Sharesave RI role"
  value       = !local.is_master_account ? aws_iam_role.nops_share_save_ri_role[0].arn : ""
}

output "nops_sharesave_payer_role_arn" {
  description = "The ARN of the Sharesave Payer role"
  value       = local.is_master_account ? aws_iam_role.nops_share_save_payer_role[0].arn : ""
}
