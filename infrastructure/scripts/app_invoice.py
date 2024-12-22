import json
import os
import logging
from datetime import datetime
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
dynamodb_table = os.getenv("dynamodb_table_name")
table = dynamodb.Table(dynamodb_table)


def lambda_handler(event, context):
    try:
        print(event)
        message = event['detail']
        UserId = message['user_id']
        PaymentID = message['payment_id']
        response = table.query(KeyConditionExpression=Key('UserId').eq(UserId) & Key('PaymentID').eq(PaymentID))
        invoice = response['Items'][0]
        print("INVOICE DETAILS")
        print("User ID : ", invoice['UserId'])
        print("Payment ID : ", invoice['PaymentID'])
        print("Amount : ", invoice['Amount'])
        print("Country : ", invoice['Country'])
        print("Transaction Date and Time : ", invoice['Timestamp'])

        return {"message": "Invoice retrived successful", "Invoice Details" : invoice}
    except Exception as err:
        print(err)
        return {"message": "Invoice retrival failed", "payment_id": message['payment_id']}