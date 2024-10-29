module "wrapper" {
  source = "../"

  for_each = var.items

  cur_bucket_name = try(each.value.cur_bucket_name, var.defaults.cur_bucket_name)
  cur_report_name = try(each.value.cur_report_name, var.defaults.cur_report_name)
}
