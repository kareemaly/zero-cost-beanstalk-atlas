# Zero Cost Beanstalk Nodejs

## Disclaimer

**Important Note:** This project is designed to deploy a single-instance Elastic Beanstalk environment that is **not scalable and not secure** (lacks HTTPS since there's no load balancer involved). It is intended **only for personal or hobby projects** and is not recommended for production use. The primary goal of this project is to enable zero-cost deployment for backend services written in Node.js (or any other language), focusing on development, testing, or demonstration purposes where scalability, security, and high availability are not of any concerns.

---

## Quick Start Guide

This quick start guide will assist in deploying your Node.js project on AWS Elastic Beanstalk using a zero-cost deployment template, for personal or test projects. Let's get started:

### Prerequisites

Before you begin, ensure you have the following installed:

- **Dotenvx:** Dotenvx is a CLI tool that allows you to run commands with environment variables loaded from a file. To install `dotenvx`, follow the instructions on the [dotenvx website](https://dotenvx.com/).

### Step 1: Prepare Environment Variables

1. **Create Environment Variables File:** Copy the `.env.pipeline.example` file to a new file named `.env.pipeline`.
2. **Fill in Details:** Open the `.env.pipeline` file and fill in the necessary details. These variables are crucial for configuring your deployment and AWS resources accurately.

### Step 2: Initialize Infrastructure

- **Run Environment Setup Command:** To initialize your infrastructure with the environment variables loaded, use:
  ```
  dotenvx run --env-file=.env.pipeline -- make reset
  ```
  This command uses Terraform to create the necessary AWS resources for your project. It prepares everything except the application environment and version, as `artifact_version` is intentionally left as null.

### Step 3: Deploy Your Application

- **Deploy Application with Environment Setup:** Deploy your application by running:
  ```
  dotenvx run --env-file=.env.pipeline -- make deploy
  ```
  This process:
  - **Builds Your Application:** Creates a zip package of your Node.js application, including the `src` directory and the package files (`package.json`, `package-lock.json`).
  - **Deploys Application Artifacts:** Uploads the application package to an S3 bucket as specified in your `.env.pipeline`.
  - **Deploys Full Infrastructure:** Applies Terraform configurations to deploy your application on AWS Elastic Beanstalk, setting up the application version with the S3 artifact and creating the environment to run your application.

---

## Destroying Your Deployment

In case you need to remove your application and all associated AWS resources, follow the steps below. This process will delete your Elastic Beanstalk environment, along with any AWS resources created during the deployment process, and clear the artifacts from the specified S3 bucket.

- **Run Environment Cleanup Command:** To safely destroy your AWS resources and clean up your deployment, run:
  ```
  dotenvx run --env-file=.env.pipeline -- make destroy
  ```
  Upon execution, you'll encounter the following steps:
  - **Confirmation Prompt:** You will be prompted to confirm the deletion of all contents in your S3 bucket (`$(TF_VAR_artifact_bucket_name)`). Type `y` or `yes` to proceed.
  - **Deleting Artifacts:** If confirmed, all artifacts in the specified S3 bucket will be deleted. This action is irreversible, so ensure you want to proceed before confirming.
  - **Destroying Infrastructure:** After clearing the S3 bucket, the command proceeds to destroy the rest of the infrastructure set up through Terraform, including the Elastic Beanstalk environment.

**Important Note:** This operation will permanently delete your deployment and all associated data in the AWS resources.
