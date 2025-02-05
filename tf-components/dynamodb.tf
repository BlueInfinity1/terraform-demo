resource "aws_dynamodb_table" "table_dev" {
  name         = var.dynamodb_table_names["dev"]
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
  hash_key = "id"
}

resource "aws_dynamodb_table" "table_test" {
  name         = var.dynamodb_table_names["test"]
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
  hash_key = "id"
}

resource "aws_dynamodb_table" "table_prod" {
  name         = var.dynamodb_table_names["prod"]
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
  hash_key = "id"
}
