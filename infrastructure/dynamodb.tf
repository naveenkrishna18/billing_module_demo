resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "nav_payment_table"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = null
  write_capacity = null
  hash_key       = "UserId"
  range_key      = "PaymentID"

  attribute {
    name = "UserId"
    type = "S"
  }
  attribute {
    name = "PaymentID"
    type = "S"
  }
}