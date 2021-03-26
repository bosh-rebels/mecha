UNAME := $(shell uname)
GOMPLATE_EXISTS := $(shell which gomplate)

readme: dependencies
	gomplate -d config=README.yml -f README.tmpl -o README.md

dependencies:
ifeq ($(UNAME), Darwin)
ifeq ($(GOMPLATE_EXISTS),)
	brew install gomplate
endif
else
ifeq ($(UNAME), Linux)
	wget https://github.com/hairyhenderson/gomplate/releases/download/v3.9.0/gomplate_linux-amd64
	mv gomplate_linux-amd64 /usr/local/bin/gomplate
	chmod +x /usr/local/bin/gomplate
endif
endif

try-terraform-bootstrap:
	cd terraform/bootstrap && \
	terraform init && \
	terraform plan

do-terraform-bootstrap:
	cd terraform/bootstrap && \
	terraform apply -auto-approve \
		-var bucket_name=$BUCKET_NAME \
		-var environment=$ENVIRONMENT

undo-terraform-bootstrap:
	cd terraform/bootstrap && \
	terraform destroy -auto-approve \
		-var bucket_name=$BUCKET_NAME \
		-var environment=$ENVIRONMENT