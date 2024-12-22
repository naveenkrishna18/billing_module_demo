import json
import os
import logging
from datetime import datetime
import boto3

dynamodb = boto3.resource('dynamodb')
dynamodb_table = os.getenv("dynamodb_table_name")
table = dynamodb.Table(dynamodb_table)


def lambda_handler(event, context):
    try:
        message = event['detail']
        Transaction_Item = {
            "UserId": message['user_id'],
            "PaymentID": message['payment_id'],
            "Country": message['country'],
            "Timestamp": str(datetime.now()),
            "Amount": message['amount']
        }

        resp = table.put_item(Item=Transaction_Item)
        print(resp)
        return {"message": "payment successful", "payment_id": message['payment_id']}
    except Exception as err:
        print(err)
        return {"message": "payment failed", "payment_id": message['payment_id']}

