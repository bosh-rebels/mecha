## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0-rc1 |
| aws | >= 3.20 |

## Resources

| Name |
|------|
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) |
| [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_control\_list | (Optional) The canned ACL to apply. Defaults to private. | `string` | n/a | yes |
| bucket | (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. | `any` | n/a | yes |
| bucket\_description | This is the bucket description | `string` | n/a | yes |
| environment | Environment name | `string` | n/a | yes |
| force\_destroy | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| lifecycle\_rule\_inputs | S3 lifecycle rules configuration | <pre>list(object({<br>    prefix                                 = string<br>    tags                                   = map(string)<br>    enabled                                = string<br>    abort_incomplete_multipart_upload_days = string<br>    expiration_inputs = list(object({<br>      days = number<br>    }))<br>    transition_inputs = list(object({<br>      days          = number<br>      storage_class = string<br>    }))<br>    noncurrent_version_transition_inputs = list(object({<br>      days          = number<br>      storage_class = string<br>    }))<br>    noncurrent_version_expiration_inputs = list(object({<br>      days = number<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "abort_incomplete_multipart_upload_days": null,<br>    "enabled": true,<br>    "expiration_inputs": [<br>      {<br>        "days": 3650,<br>        "expired_object_delete_marker": false<br>      }<br>    ],<br>    "noncurrent_version_expiration_inputs": [],<br>    "noncurrent_version_transition_inputs": [],<br>    "prefix": "",<br>    "tags": {<br>      "autoclean": "true",<br>      "rule": "log"<br>    },<br>    "transition_inputs": []<br>  }<br>]</pre> | no |
| logging\_inputs | S3 logging configuration | <pre>list(object({<br>    target_bucket = string<br>    target_prefix = string<br>  }))</pre> | `null` | no |
| public\_access | Set default public access policy for S3 bucket | `map(string)` | <pre>{<br>  "block_public_acls": "true",<br>  "block_public_policy": "true",<br>  "ignore_public_acls": "true",<br>  "restrict_public_buckets": "true"<br>}</pre> | no |
| server\_side\_encryption\_configuration\_inputs | S3 server side encryption configuration | <pre>list(object({<br>    sse_algorithm     = string<br>    kms_master_key_id = string<br>  }))</pre> | `null` | no |
| versioning\_inputs | S3 versioning configuration | <pre>list(object({<br>    enabled    = bool<br>    mfa_delete = bool<br>  }))</pre> | <pre>[<br>  {<br>    "enabled": true,<br>    "mfa_delete": null<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | ARN of S3 bucket |
| bucket\_id | ID of S3 bucket |
| bucket\_name | S3 Bucket name |
