SHELL := /bin/bash

install:
	@echo "Installing dependencies"
	npm install

build: install
	@echo "========= Packaging the application"
	@echo "========= Building the application"
	@mkdir -p dist
	@rm -f ./dist/$(TF_VAR_artifact_version).zip
	@zip -r ./dist/$(TF_VAR_artifact_version).zip src package.json package-lock.json
	@echo "========= Application built"

deploy-artifact-infra:
	@echo "========= Deploying the artifact infrastructure (S3 bucket)"
	@export TF_LOG=ERROR
	@cd terraform && terraform apply -target=aws_s3_bucket.artifact
	@echo "========= Artifact infrastructure deployed"

deploy-app:
	@echo "========= Deploying the application"
	@echo "========= Uploading the artifact to S3"
	@echo "========= Artifact version: $(TF_VAR_artifact_version)"
	@echo "========= Artifact bucket: $(TF_VAR_artifact_bucket_name)"
	@aws s3 cp dist/$(TF_VAR_artifact_version).zip s3://$(TF_VAR_artifact_bucket_name)/$(TF_VAR_artifact_version).zip
	@echo "========= Artifact uploaded"

deploy-infra:
	@echo "========= Deploying the full infrastructure"
	@cd terraform && terraform apply
	@echo "========= Full infrastructure deployed"

# Deploy target
deploy: build deploy-artifact-infra deploy-app deploy-infra

reset:
	@echo "========= Resetting the infrastructure"
	@cd terraform && terraform apply -var "artifact_version=''"
	@echo "========= Infrastructure reset"
