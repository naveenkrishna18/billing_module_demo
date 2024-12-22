# Billing Module
A simple system to write payment details to dynamo and reads to create an invoice.

## Components
- Event rules - To trigger corresponding lambda.
- Dynamodb - To store the payment details
- Lambda Function - to read and write from lambda.

## Repository Structure
- Infrastructure - contains all infra and scripts
    - terraform_modules - contains terraform module for lambda Function
    - scripts - contains all the python scripts
    - terraform.tf - terraform configurations
    - dynamodb.tf - dynamodb table creation
    - lambda.tf - lambda function creation
    - events.tf - event rule creation
- put_events.py - sample python code to put event to an eventbridge

## Architecture Diagram
![image](https://github.com/user-attachments/assets/3fddf36d-28b2-4dd5-a3a9-18104bd74701)
