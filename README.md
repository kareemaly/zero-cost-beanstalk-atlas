# Zero Cost Beanstalk Nodejs

## Disclaimer

**Important Note:** This project is designed to deploy a single-instance Elastic Beanstalk environment that is **not scalable and not secure** (lacks HTTPS since there's no load balancer involved). It is intended **only for personal or hobby projects** and is not recommended for production use. The primary goal of this project is to enable zero-cost deployment for backend services written in Node.js (or any other language), focusing on development, testing, or demonstration purposes where scalability, security, and high availability are not of any concerns.

## Quick Start Guide

This quick start guide will help you deploy your Node.js project on AWS Elastic Beanstalk using a zero-cost deployment template ideal for personal or test projects. Follow these steps to get started:

### Step 1: Prepare Environment Variables

1. **Create Environment Variables File:** Copy the `.env.pipeline.example` file to a new file named `.env.pipeline`.
2. **Fill in Details:** Open the `.env.pipeline` file and fill in the necessary details. These variables are essential for configuring your deployment and AWS resources correctly.

### Step 2: Initialize Infrastructure

- **Run `make reset` Command:** This command initializes Terraform and creates the AWS resources needed for your project. It sets up everything except the application environment and version since `artifact_version` is left as null. This step prepares your AWS environment without deploying the application itself.

### Step 3: Deploy Your Application

- **Run `make deploy` Command:** This is where the magic happens. The `make deploy` command executes a series of actions:
  - **Builds Your Application:** Packages your Node.js application into a zip file, including the `src` directory and package files (`package.json`, `package-lock.json`).
  - **Deploys Application Artifacts:** Uploads the packaged application to an S3 bucket specified in your `.env.pipeline`.
  - **Deploys Full Infrastructure:** Applies Terraform configurations to deploy your application on AWS Elastic Beanstalk. This step also includes setting up the application version using the artifact uploaded to S3 and creating the Elastic Beanstalk environment to run your application.

By following these steps, you can quickly start deploying your Node.js projects on AWS Elastic Beanstalk, taking advantage of a zero-cost deployment strategy suitable for personal or test projects.
