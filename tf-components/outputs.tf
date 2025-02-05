output "api_endpoint_dev" {
  value = aws_apigatewayv2_api.terraform_api_dev.api_endpoint
}

output "api_endpoint_test" {
  value = aws_apigatewayv2_api.terraform_api_test.api_endpoint
}

output "api_endpoint_prod" {
  value = aws_apigatewayv2_api.terraform_api_prod.api_endpoint
}
