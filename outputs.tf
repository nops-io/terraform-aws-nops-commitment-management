output "cur_bucket_arn" {
  description = "The ARN of the CUR S3 bucket"
  value       = aws_s3_bucket.nops_cur_bucket.arn
}
