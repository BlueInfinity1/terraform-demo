# LAMBDA INVOKE PERMISSIONS

resource "aws_lambda_permission" "apigw_lambda_dev" {
  statement_id  = "AllowAPIGatewayInvokeDev"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_dev.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.terraform_api_dev.execution_arn}/*/*"
}

resource "aws_lambda_permission" "apigw_lambda_test" {
  statement_id  = "AllowAPIGatewayInvokeTest"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_test.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.terraform_api_test.execution_arn}/*/*"
}

resource "aws_lambda_permission" "apigw_lambda_prod" {
  statement_id  = "AllowAPIGatewayInvokeProd"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_prod.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.terraform_api_prod.execution_arn}/*/*"
}

# LAMDBA AUTHORIZER PERMISSIONS

resource "aws_lambda_permission" "apigw_lambda_authorizer_dev" {
  statement_id  = "AllowAPIGatewayInvokeAuthorizerDev"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_authorizer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.terraform_api_dev.execution_arn}/*/*"
}

resource "aws_lambda_permission" "apigw_lambda_authorizer_test" {
  statement_id  = "AllowAPIGatewayInvokeAuthorizerTest"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_authorizer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.terraform_api_test.execution_arn}/*/*"
}

resource "aws_lambda_permission" "apigw_lambda_authorizer_prod" {
  statement_id  = "AllowAPIGatewayInvokeAuthorizerProd"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_authorizer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.terraform_api_prod.execution_arn}/*/*"
}
