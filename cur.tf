resource "aws_cur_report_definition" "example_cur_report_definition" {
  report_name                = var.cur_report_name
  refresh_closed_reports     = true
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.nops_cur_bucket.id
  s3_prefix                  = "sharesave"
  s3_region                  = "us-east-1"
  time_unit                  = "HOURLY"
  report_versioning          = "OVERWRITE_REPORT"
  additional_artifacts       = ["REDSHIFT"]
  compression                = "GZIP"
  format                     = "textORcsv"
}
