resource "aws_cur_report_definition" "nops_cur" {
  count                      = local.is_master_account ? 1 : 0
  report_name                = var.cur_report_name
  refresh_closed_reports     = true
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.nops_cur_bucket[0].id
  s3_prefix                  = "sharesave"
  s3_region                  = data.aws_region.current.id
  time_unit                  = "HOURLY"
  report_versioning          = "OVERWRITE_REPORT"
  additional_artifacts       = ["REDSHIFT"]
  compression                = "GZIP"
  format                     = "textORcsv"

  lifecycle {
    precondition {
      condition     = local.is_master_account && var.cur_report_name != ""
      error_message = "CUR report name must be set when applying the configuration on the master account."
    }
  }
}
