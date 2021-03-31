import boto3
import json

def lambda_handler(context, event):
    print("This is dummy code")
    sns_topic_arn = 'arn:aws:sns:us-east-1:362863965643:macie-msg'