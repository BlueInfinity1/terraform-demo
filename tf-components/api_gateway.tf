#############################
# DEV Environment API
#############################

resource "aws_apigatewayv2_api" "terraform_api_dev" {
  name          = "${var.api_name}-dev"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "integration_dev" {
  api_id             = aws_apigatewayv2_api.terraform_api_dev.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_dev.invoke_arn
}

resource "aws_apigatewayv2_authorizer" "lambda_authorizer_dev" {
  api_id                            = aws_apigatewayv2_api.terraform_api_dev.id
  authorizer_type                   = "REQUEST"
  name                              = "LambdaAuthorizer-dev"
  identity_sources                  = ["$request.header.Authorization"]
  authorizer_uri                    = aws_lambda_function.lambda_authorizer.invoke_arn
  authorizer_payload_format_version = "2.0"
  enable_simple_responses           = true
}

resource "aws_apigatewayv2_route" "route_dev" {
  depends_on         = [aws_apigatewayv2_authorizer.lambda_authorizer_dev]
  api_id             = aws_apigatewayv2_api.terraform_api_dev.id
  route_key          = "POST /invoke"
  target             = "integrations/${aws_apigatewayv2_integration.integration_dev.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.lambda_authorizer_dev.id
}

resource "aws_apigatewayv2_stage" "stage_dev" {
  api_id      = aws_apigatewayv2_api.terraform_api_dev.id
  name        = "dev"
  auto_deploy = true
}

#############################
# TEST Environment API
#############################

resource "aws_apigatewayv2_api" "terraform_api_test" {
  name          = "${var.api_name}-test"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "integration_test" {
  api_id             = aws_apigatewayv2_api.terraform_api_test.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_test.invoke_arn
}

resource "aws_apigatewayv2_authorizer" "lambda_authorizer_test" {
  api_id                            = aws_apigatewayv2_api.terraform_api_test.id
  authorizer_type                   = "REQUEST"
  name                              = "LambdaAuthorizer-test"
  identity_sources                  = ["$request.header.Authorization"]
  # Reusing the same Lambda authorizer for all environments:
  authorizer_uri                    = aws_lambda_function.lambda_authorizer.invoke_arn
  authorizer_payload_format_version = "2.0"
  enable_simple_responses           = true
}

resource "aws_apigatewayv2_route" "route_test" {
  depends_on         = [aws_apigatewayv2_authorizer.lambda_authorizer_test]
  api_id             = aws_apigatewayv2_api.terraform_api_test.id
  route_key          = "POST /invoke"
  target             = "integrations/${aws_apigatewayv2_integration.integration_test.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.lambda_authorizer_test.id
}

resource "aws_apigatewayv2_stage" "stage_test" {
  api_id      = aws_apigatewayv2_api.terraform_api_test.id
  name        = "test"
  auto_deploy = true
}

#############################
# PROD Environment API
#############################

resource "aws_apigatewayv2_api" "terraform_api_prod" {
  name          = "${var.api_name}-prod"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "integration_prod" {
  api_id             = aws_apigatewayv2_api.terraform_api_prod.id
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_prod.invoke_arn
}

resource "aws_apigatewayv2_authorizer" "lambda_authorizer_prod" {
  api_id                            = aws_apigatewayv2_api.terraform_api_prod.id
  authorizer_type                   = "REQUEST"
  name                              = "LambdaAuthorizer-prod"
  identity_sources                  = ["$request.header.Authorization"]
  # Reusing the same Lambda authorizer for all environments:
  authorizer_uri                    = aws_lambda_function.lambda_authorizer.invoke_arn
  authorizer_payload_format_version = "2.0"
  enable_simple_responses           = true
}

resource "aws_apigatewayv2_route" "route_prod" {
  depends_on         = [aws_apigatewayv2_authorizer.lambda_authorizer_prod]
  api_id             = aws_apigatewayv2_api.terraform_api_prod.id
  route_key          = "POST /invoke"
  target             = "integrations/${aws_apigatewayv2_integration.integration_prod.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.lambda_authorizer_prod.id
}

resource "aws_apigatewayv2_stage" "stage_prod" {
  api_id      = aws_apigatewayv2_api.terraform_api_prod.id
  name        = "prod"
  auto_deploy = true
}
