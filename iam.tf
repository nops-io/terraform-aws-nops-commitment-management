resource "aws_iam_role" "nops_share_save_mgt_role" {
  count = !local.is_master_account ? 1 : 0
  name  = "nops-sharesave-mgt"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${local.share_save_mgt_principal}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachments_exclusive" "nops_share_save_mgt_managed_policies" {
  count     = !local.is_master_account ? 1 : 0
  role_name = aws_iam_role.nops_share_save_mgt_role[0].name
  policy_arns = [
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AWSSavingsPlansFullAccess",
    "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"
  ]
}

resource "aws_iam_role_policy" "nops_sharesave_mgt_policy" {
  count = !local.is_master_account ? 1 : 0
  name  = "NopsSharesaveMgtPolicy"
  role  = aws_iam_role.nops_share_save_mgt_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeReservedInstances",
          "ec2:DescribeReservedInstancesListings",
          "ec2:DescribeReservedInstancesModifications",
          "ec2:DescribeReservedInstancesOfferings",
          "ec2:ModifyReservedInstances",
          "ec2:PurchaseReservedInstancesOffering",
          "ec2:CreateReservedInstancesListing",
          "ec2:CancelReservedInstancesListing",
          "ec2:GetReservedInstancesExchangeQuote",
          "ec2:AcceptReservedInstancesExchangeQuote",
          "rds:PurchaseReservedDBInstancesOffering",
          "rds:DescribeReservedDBInstancesOfferings",
          "rds:DescribeReservedDBInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "nops_share_save_ri_role" {
  count = !local.is_master_account ? 1 : 0
  name  = "nops-sharesave-ri"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${local.share_save_ri_principal}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachments_exclusive" "nops_share_save_ri_managed_policies" {
  count     = !local.is_master_account ? 1 : 0
  role_name = aws_iam_role.nops_share_save_ri_role[0].name
  policy_arns = [
    "arn:aws:iam::aws:policy/AWSSavingsPlansFullAccess"
  ]
}

resource "aws_iam_role_policy" "nops_sharesave_ri_policy" {
  count = !local.is_master_account ? 1 : 0
  name  = "NopsSharesaveRIPolicy"
  role  = aws_iam_role.nops_share_save_ri_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeReservedInstances",
          "ec2:DescribeReservedInstancesListings",
          "ec2:DescribeReservedInstancesModifications",
          "ec2:DescribeReservedInstancesOfferings",
          "ec2:ModifyReservedInstances",
          "ec2:PurchaseReservedInstancesOffering",
          "ec2:CreateReservedInstancesListing",
          "ec2:CancelReservedInstancesListing",
          "ec2:GetReservedInstancesExchangeQuote",
          "ec2:AcceptReservedInstancesExchangeQuote",
          "rds:PurchaseReservedDBInstancesOffering",
          "rds:DescribeReservedDBInstancesOfferings",
          "rds:DescribeReservedDBInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "nops_share_save_payer_role" {
  count = local.is_master_account ? 1 : 0
  name  = "nops-sharesave-payer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${local.share_save_ri_principal}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachments_exclusive" "nops_share_save_payer_managed_policies" {
  count     = local.is_master_account ? 1 : 0
  role_name = aws_iam_role.nops_share_save_payer_role[0].name
  policy_arns = [
    "arn:aws:iam::aws:policy/AWSSupportAccess"
  ]
}

resource "aws_iam_role_policy" "nops_sharesave_policy" {
  count = local.is_master_account ? 1 : 0
  name  = "NopsSharesavePayerPolicy"
  role  = aws_iam_role.nops_share_save_payer_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "arn:${data.aws_partition.current.id}:s3:::${aws_s3_bucket.nops_cur_bucket[0].id}"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:${data.aws_partition.current.id}:s3:::${aws_s3_bucket.nops_cur_bucket[0].id}/*"
        ]
      }
    ]
  })
}
