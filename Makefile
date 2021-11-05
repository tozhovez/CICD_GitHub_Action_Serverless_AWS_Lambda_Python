#AWS_PROFILE_DEV := default
#AWS_PROFILE_PROD := production
PROJECTNAME=$(shell basename "$(PWD)")
PACKAGE_PREFIX := CICD_GitHub_Action_Serverless_AWS_Lambda_Python/aws-python-http-api-app
PACKAGE := aws-python-http-api-app
STORAGE := ${HOME}/aws-python
#REQ_FILE = ./queries-test-tools/Infra/requirements.txt
PYTHON := $(shell which python)
PIP := $(shell which pip)
PYV := $(shell $(PYTHON) -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)")
PWD := $(shell pwd)
SHELL = /bin/bash
EXPORT_VERSION = $(eval VERSION=$(shell cat .version))
#   Makefile

.PHONY: clean

.DEFAULT_GOAL: help

help: ## Show this help
	@printf "\n\033[33m%s:\033[1m\n" 'Choose available commands run in "$(PROJECTNAME)"'
	@echo "======================================================"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[32m%-14s		\033[35;1m-- %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@printf "\033[33m%s\033[1m\n"
	@echo "======================================================"


envs: ## Print environment variables
	@echo "======================================================"
	@echo  "REQ_FILE: $(REQ_FILE)"
	@echo  "PYTHON: $(PYTHON)"
	@echo  "PIP: $(PIP)"
	@echo  "PYV: $(PYV)"
	@echo  "shell $(SHELL)"
	@echo  "pwd $(PWD)"
	@echo "======================================================"

#setup-infra: ## Script called setup.sh Installing pr-required dependency
#	@echo "======================================================"
#	@chmod 777 -R ./
#	@chmod +x ./queries-test-tools/Infra/setup.sh
#	@$(SHELL) ./queries-test-tools/Infra/setup.sh


install-requirements: ## Install requirements
	@echo "======================================================"
	$(PIP) install --upgrade pip
	$(PIP) install -r $(REQ_FILE)
	@echo "======================================================"


#set-aws-dev-profile: ## SET AWS DEV PROFILE
#	@export AWS_PROFILE=$(AWS_PROFILE_DEV)


#queries-test-tools: set-aws-dev-profile ## Run locally queries-test-tools
#	@$(PYTHON) ./queries-test-tools/Infra/scripts/queries_lists.py

install-serverless: ## Install serverless via npm (npm must be installed)
	@echo "======================================================"
	@echo "Install serverless via npm (npm must be installed)"
	@echo "======================================================"
	@npm install -g serverless


#deploy-send-email-data-dev: ## Deploying send-email-data lambdas to dev
#	@echo "deploying send-email-data lambdas to dev"
#	@echo "======================================================"
#	@cd send-data-serverless && npm install
#	@cd send-data-serverless && SLS_DEBUG=1 serverless deploy --stage dev-send-email --aws-profile $(AWS_PROFILE_DEV) -v

#invoke-send-email-data-dev: ## Invoke send-email-data lambdas in dev
#	@echo "======================================================"
#	@cd send-data-serverless && serverless logs -f data-daily -t --stage dev-send-email --aws-profile $(AWS_PROFILE_DEV) -v &
#	@cd send-data-serverless && serverless logs -f data-monthly -t --stage dev-send-email --aws-profile $(AWS_PROFILE_DEV) -v &


#remove-send-email-data-dev: ## Removing send-email-data lambdas
#	@echo "======================================================"
#	@cd send-data-serverless && serverless remove --stage dev-send-email --aws-profile $(AWS_PROFILE_DEV) -v


#deploy-send-email-data-prod: ## Deploying send-email-data lambdas to production
#	@echo "======================================================"
#	@echo "deploying send-email-data lambdas to production"
#	@cd send-data-serverless && npm install
#	@cd send-data-serverless && SLS_DEBUG=1 serverless deploy --stage send-email --aws-profile $(AWS_PROFILE_PROD) -v
#
#
#remove-send-email-data-prod: ## Removing send-email-data lambdas
#	@echo "======================================================"
#	@cd send-data-serverless && serverless remove --stage send-email --aws-profile $(AWS_PROFILE_PROD) -v
#
#
#deploy-aggregate-data-dev: ## Deploying aggregate-data lambdas to dev
#	@echo "======================================================"
#	@cd aggregate-data-serverless && npm install
#	@cd aggregate-data-serverless && SLS_DEBUG=1 serverless deploy --stage dev-aggregate-data --aws-profile $(AWS_PROFILE_DEV) -v
#	@echo "======================================================"
#	@echo "DEBUG"
#	@cd aggregate-data-serverless && serverless info --stage dev-aggregate-data --aws-profile $(AWS_PROFILE_DEV) -v
#
#
#invoke-aggregate-data-dev: ## Invoking aggregate-data lambdas dev
#	@cd aggregate-data-serverless && serverless logs -f daily-aggregator -t --stage dev-aggregate-data --aws-profile $(AWS_PROFILE_DEV) -v &
#	@cd aggregate-data-serverless && serverless logs -f aggregator-call-next-task -t --stage dev-aggregate-data --aws-profile $(AWS_PROFILE_DEV) -v &
#	@cd aggregate-data-serverless && serverless logs -f monthly-aggregator -t --stage dev-aggregate-data --aws-profile $(AWS_PROFILE_DEV) -v &
#
#
#remove-aggregate-data-dev: ## Remove aggregate-data
#	@echo "======================================================"
#	@cd aggregate-data-serverless && serverless remove --stage dev-aggregate-data --aws-profile $(AWS_PROFILE_DEV) -v
#
#
#
#deploy-aggregate-data-prod: ## Deploying aggregate-data lambdas to production
#	@echo "======================================================"
#	@cd aggregate-data-serverless && npm install
#	@cd aggregate-data-serverless && SLS_DEBUG=1 serverless deploy --stage aggregate-data --aws-profile $(AWS_PROFILE_PROD) -v
#
#
#remove-aggregate-data-prod: ## Remove aggregate-data
#	@echo "======================================================"
#	@cd aggregate-data-serverless && serverless remove --stage aggregate-data --aws-profile $(AWS_PROFILE_PROD) -v


clean: ## Clean sources
	@echo "======================================================"
	@echo clean $(PROJECTNAME)
	@echo $(find ./* -maxdepth 0 -name "*.pyc" -type f)
	echo $(find . -name ".DS_Store" -type f)
	@rm -fR __pycache__ venv "*.pyc"
	@find ./* -maxdepth 0 -name "*.pyc" -type f -delete
	@find ./* -name '*.py[cod]' -delete
	@find ./* -name '__pycache__' -delete
	find . -name '*.DS_Store' -delete


list: ## Makefile target list
	@echo "======================================================"
	@echo Makefile target list
	@echo "======================================================"
	@cat Makefile | grep "^[a-z]" | awk '{print $$1}' | sed "s/://g" | sort
