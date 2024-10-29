variable "cur_report_name" {
  type        = string
  description = "Name of the CUR report."
}

variable "cur_bucket_name" {
  type        = string
  description = "The S3 bucket name to be used to setup CUR integration. This name has to be unique globally."
}
