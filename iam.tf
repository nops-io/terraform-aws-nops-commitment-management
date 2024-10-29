resource "aws_iam_role" "nops_share_save_mgt_role" {
  name = "NopsSharesaveMgt"

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
  role_name = aws_iam_role.nops_share_save_mgt_role.name
  policy_arns = [
    "arn:aws:iam::aws:policy/AWSSupportAccess",             # Verify
    "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess", # Verify
    "arn:aws:iam::aws:policy/AWSOrganizationsReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AWSSavingsPlansFullAccess",
    "arn:aws:iam::aws:policy/ServiceQuotasFullAccess"
  ]
}

resource "aws_iam_role_policy" "nops_sharesave_mgt_policy" {
  name = "NopsSharesaveMgtPolicy"
  role = aws_iam_role.nops_share_save_mgt_role.id

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
  name = "NopsSharesaveRI"

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
  role_name = aws_iam_role.nops_share_save_ri_role.name
  policy_arns = [
    "arn:aws:iam::aws:policy/AWSSavingsPlansFullAccess"
  ]
}

resource "aws_iam_role_policy" "nops_sharesave_ri_policy" {
  name = "NopsSharesaveRIPolicy"
  role = aws_iam_role.nops_share_save_ri_role.id

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
  name = "NopsSharesavePayer"

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
  role_name = aws_iam_role.nops_share_save_payer_role.name
  policy_arns = [
    "arn:aws:iam::aws:policy/AWSSupportAccess"
  ]
}

resource "aws_iam_role_policy" "nops_sharesave_policy" {
  name = "NopsSharesavePayerPolicy"
  role = aws_iam_role.nops_share_save_payer_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "arn:${data.aws_partition.current.id}:s3:::${aws_s3_bucket.nops_cur_bucket.id}"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucket",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:${data.aws_partition.current.id}:s3:::${aws_s3_bucket.nops_cur_bucket.id}/*"
        ]
      }
    ]
  })
}
