# Archive the authorizer source code located in ../lambdas/authorizer
data "archive_file" "authorizer_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../lambdas/authorizer"
  output_path = "${path.module}/../lambdas/authorizer.zip"
}

resource "aws_lambda_function" "lambda_authorizer" {
  function_name    = var.authorizer_function_name
  role             = aws_iam_role.authorizer_role.arn
  runtime          = "nodejs18.x"
  handler          = "authorizer.handler"
  filename         = "${path.module}/../lambdas/authorizer.zip"
  source_code_hash = data.archive_file.authorizer_zip.output_base64sha256
  timeout          = 5
}
