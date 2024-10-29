resource "aws_s3_bucket" "nops_cur_bucket" {
  bucket        = var.cur_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "nops_cur_bucket_encryption" {
  bucket = aws_s3_bucket.nops_cur_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "nops_cur_bucket_block_public_access" {
  bucket = aws_s3_bucket.nops_cur_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "nops_cur_bucket_policy" {
  bucket = aws_s3_bucket.nops_cur_bucket.id
  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.nops_cur_bucket.arn,
          "${aws_s3_bucket.nops_cur_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy"
        ],
        Resource = [
          "arn:${data.aws_partition.current.id}:s3:::${aws_s3_bucket.nops_cur_bucket.id}"
        ],
        Principal = {
          Service = ["billingreports.amazonaws.com"]
        }
      },
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = [
          "arn:${data.aws_partition.current.id}:s3:::${aws_s3_bucket.nops_cur_bucket.id}/*"
        ],
        Principal = {
          Service = ["billingreports.amazonaws.com"]
        }
      }
    ]
  })
}
