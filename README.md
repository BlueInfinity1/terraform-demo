# Terraform Demo Project

This project demonstrates how to deploy a multi-environment serverless API using Terraform. It provisions separate API Gateway HTTP APIs for **DEV**, **TEST**, and **PROD** environments, each integrating with its own version of a Lambda function. A custom Lambda authorizer is used to secure the endpoints, though for this demo a simple check is implemented instead of robust JWT or IAM‑based authentication.

## Overview

- **API Gateway HTTP APIs:**  
  - Separate API Gateway resources are created for each environment.
  - Each API has its own integration, route, and stage.
  - Endpoints are exposed as:
    - DEV: `https://<dev-api-id>.execute-api.<region>.amazonaws.com/dev/invoke`
    - TEST: `https://<test-api-id>.execute-api.<region>.amazonaws.com/test/invoke`
    - PROD: `https://<prod-api-id>.execute-api.<region>.amazonaws.com/prod/invoke`

- **AWS Lambda Functions:**  
  - **Main Lambda Functions:** Three versions are deployed (dev, test, prod). Each function is configured with an environment variable that specifies the corresponding DynamoDB table, to which the Lambda writes random numbers.
  - **Lambda Aliases:** Aliases are defined (dev, test, prod) for versioning, though the API integration currently references the function’s invoke ARN.
  - **Lambda Authorizer:** A single (shared) authorizer function is used to authorize API calls. The demo authorizer simply returns `true` if the `Authorization` header equals `"allow"`.
  - **Packing:** All Lambda code is packed to zips and uploaded to AWS as packages.
  
- **IAM and CloudWatch Logging:**  
  - IAM roles and policies are set up for Lambda functions and the authorizer.
  - The Lambda execution roles have permissions to write logs to CloudWatch.
