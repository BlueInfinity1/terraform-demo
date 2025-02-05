data "archive_file" "lambda_main_zip" {
  type        = "zip"
  # Assumes your main Lambda source is in the ../lambdas/main directory
  source_dir  = "${path.module}/../lambdas/main"
  output_path = "${path.module}/../lambdas/main.zip"
}

# The "dev" version: this is the main function (TerraformLambda) with dev settings.
resource "aws_lambda_function" "lambda_dev" {
  function_name    = "TerraformLambda"  # This will be the main function name
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs18.x"
  handler          = "index.handler"
  filename         = "${path.module}/../lambdas/main.zip"
  source_code_hash = data.archive_file.lambda_main_zip.output_base64sha256
  timeout          = 15

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_names["dev"],      
    }
  }
}

# The "test" version: a separate resource using the same code but different environment variable.
resource "aws_lambda_function" "lambda_test" {
  function_name    = "TerraformLambda_Test"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs18.x"
  handler          = "index.handler"
  filename         = "${path.module}/../lambdas/main.zip"
  source_code_hash = data.archive_file.lambda_main_zip.output_base64sha256
  timeout          = 15

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_names["test"],      
    }
  }
}

# The "prod" version: again, same code but configured for production.
resource "aws_lambda_function" "lambda_prod" {
  function_name    = "TerraformLambda_Prod"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs18.x"
  handler          = "index.handler"
  filename         = "${path.module}/../lambdas/main.zip"
  source_code_hash = data.archive_file.lambda_main_zip.output_base64sha256
  timeout          = 15

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_names["prod"],      
    }
  }
}

# Create aliases for each “version”
resource "aws_lambda_alias" "alias_dev" {
  name             = "dev"
  function_name    = aws_lambda_function.lambda_dev.function_name
  # Here we use "$LATEST" as the published version; in a more advanced setup you’d publish a version resource.
  function_version = "$LATEST"
}

resource "aws_lambda_alias" "alias_test" {
  name             = "test"
  function_name    = aws_lambda_function.lambda_test.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_alias" "alias_prod" {
  name             = "prod"
  function_name    = aws_lambda_function.lambda_prod.function_name
  function_version = "$LATEST"
}
