# Dealing with the tf backend

We expect the tf backend to be set in a generated fashion.

The file describing the terraform backend will be named enviroment.tfbackend and will be generated through the Makefile.
The content will look like this:

```
encrypt = true
bucket  = "some-tf-state-bucket"
key     = "terraform/aws-bosh-infra/terraform.tfstate"
region  = "the-region"
```

In order to use this file one needs to cd into terraform/aws-bosh-infra and execute the following:

`terraform init -reconfigure -backend-config=../environment.tfbackend`