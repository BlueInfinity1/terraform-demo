# Role for the main Lambda functions
resource "aws_iam_role" "lambda_role" {
  name = "TerraformLambdaRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy" "lambda_dynamodb_write_policy" {
  name        = "TerraformLambdaDynamoDBWritePolicy"
  description = "Allow Lambda to write to the Terraform tables"
  policy      = jsonencode({
    Version: "2012-10-17",
    Statement: [{
      Effect: "Allow",
      Action: [
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ],
      Resource: "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/TerraformTable*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_dynamodb_write_policy.arn
}

# Attach the AWSLambdaBasicExecutionRole to enable CloudWatch logs
resource "aws_iam_role_policy_attachment" "lambda_basic_exec" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Role for the Lambda authorizer
resource "aws_iam_role" "authorizer_role" {
  name = "TerraformLambdaAuthorizerRole"
  assume_role_policy = jsonencode({
    Version: "2012-10-17",
    Statement: [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "authorizer_basic_exec" {
  role       = aws_iam_role.authorizer_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
