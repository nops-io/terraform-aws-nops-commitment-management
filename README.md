# terraform-aws-nops-commitment-management
Terraform module for commitment management integration with AWS using the nOps platform

## Features
- Creation of an S3 bucket and CUR report
- Creation IAM roles with the necessary permissions required by the nOps platform
- Automatic detection of payer and child accounts for correct creation of only necessary resources

## Prerequisites

- Terraform v1.2+
- AWS CLI configured with appropriate permissions

## Usage

### Onboarding Payer account

The below example shows how to add the management (root) AWS account integration:

> The CUR report name and bucket name are only required to deploy the module to the Payer account.


1. Being authenticated on the Payer account of the AWS organization, add the following code:
```hcl
provider "aws" {
  alias  = "root"
}

module cm_onboarding {
  providers = {
    aws = aws.root
  }
  source             = "nops-io/nops-commitment-management/aws"
  # Make sure the bucket name is unique globally, this is a requisite by AWS
  cur_bucket_name = "my_cur_bucket"
  # CUR report display name
  cur_report_name = "my_cur_report"
}
```

2. Initialize Terraform:

```
terraform init
```

3. Plan and apply the Terraform configuration:

```
terraform plan -out=plan

terraform apply plan
```


### Onboarding child account

Onboarding child accounts is performed using the same module, it already contains the logic to react when its being applied on any account that is not root
```hcl
provider "aws" {
  alias  = "child"
}

module cm_onboarding {
  providers = {
    aws = aws.child
  }
  source             = "nops-io/nops-commitment-management/aws"
  # No variables are required to deploy this module on child accounts
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cur_report_definition.nops_cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition) | resource |
| [aws_iam_role.nops_share_save_mgt_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.nops_share_save_payer_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.nops_share_save_ri_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.nops_sharesave_mgt_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.nops_sharesave_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.nops_sharesave_ri_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachments_exclusive.nops_share_save_mgt_managed_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_iam_role_policy_attachments_exclusive.nops_share_save_payer_managed_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_iam_role_policy_attachments_exclusive.nops_share_save_ri_managed_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_s3_bucket.nops_cur_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.nops_cur_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.nops_cur_bucket_block_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.nops_cur_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cur_bucket_name"></a> [cur\_bucket\_name](#input\_cur\_bucket\_name) | The S3 bucket name to be used to setup CUR integration. This name has to be unique globally. | `string` | `""` | no |
| <a name="input_cur_report_name"></a> [cur\_report\_name](#input\_cur\_report\_name) | Name of the CUR report. | `string` | `""` | no |

## Outputs
 
| Name | Description |
|------|-------------|
| <a name="output_cur_bucket_arn"></a> [cur\_bucket\_arn](#output\_cur\_bucket\_arn) | The ARN of the CUR S3 bucket |
| <a name="output_nops_sharesave_mgt_role_arn"></a> [nops\_sharesave\_mgt\_role\_arn](#output\_nops\_sharesave\_mgt\_role\_arn) | The ARN of the Sharesave Management role |
| <a name="output_nops_sharesave_payer_role_arn"></a> [nops\_sharesave\_payer\_role\_arn](#output\_nops\_sharesave\_payer\_role\_arn) | The ARN of the Sharesave Payer role |
| <a name="output_nops_sharesave_ri_role_arn"></a> [nops\_sharesave\_ri\_role\_arn](#output\_nops\_sharesave\_ri\_role\_arn) | The ARN of the Sharesave RI role |
<!-- END_TF_DOCS -->
