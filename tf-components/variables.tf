variable "region" {
  default = "us-west-2"
}

variable "api_name" {
  default = "TerraformDemoAPI"
}

variable "lambda_function_name" {
  default = "TerraformLambda"
}

variable "authorizer_function_name" {
  default = "TerraformLambdaAuthorizer"
}

variable "dynamodb_table_names" {
  type = map(string)
  default = {
    dev  = "TerraformTableDev"
    test = "TerraformTableTest"
    prod = "TerraformTableProd"
  }
}
