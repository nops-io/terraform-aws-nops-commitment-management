output "cur_bucket_arn" {
  description = "The ARN of the CUR S3 bucket"
  value       = aws_s3_bucket.nops_cur_bucket.arn
}

output "nops_sharesave_mgt_role_arn" {
  description = "The ARN of the Sharesave Management role"
  value       = aws_iam_role.nops_share_save_mgt_role.arn
}

output "nops_sharesave_ri_role_arn" {
  description = "The ARN of the Sharesave RI role"
  value       = aws_iam_role.nops_share_save_ri_role.arn
}

output "nops_sharesave_payer_role_arn" {
  description = "The ARN of the Sharesave Payer role"
  value       = aws_iam_role.nops_share_save_payer_role.arn
}
