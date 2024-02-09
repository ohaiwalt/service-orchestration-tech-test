build:
	docker build -t pw/crudservice:latest ./service/

run: build
	docker run -it --rm --name pwcrudservice -p 8000:8000 -v ./service.cfg:/app/service.cfg pw/crudservice:latest

### updates below this line ###

ecr_repository_url := $$(terraform -chdir=infra/ecr-repository output -raw ecr_repository_url)
ecr_image := "$(ecr_repository_url):latest"
aws_account_id := $$(aws sts get-caller-identity --query Account --output text)
aws_region := $$(aws configure get region)

check-tools:
	@command -v aws >/dev/null 2>&1 || { echo >&2 "awscli is required but it's not installed. Aborting."; exit 1; }
	@command -v terraform >/dev/null 2>&1 || { echo >&2 "Terraform is required but it's not installed. Aborting."; exit 1; }
	@command -v kubectl >/dev/null 2>&1 || { echo >&2 "kubectl is required but it's not installed. Aborting."; exit 1; }
	@command -v helm >/dev/null 2>&1 || { echo >&2 "Helm is required but it's not installed. Aborting."; exit 1; }
	@echo "All required dependencies are installed."

ecr-login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(aws_account_id).dkr.ecr.$(aws_region).amazonaws.com

build-remote:
	docker build -t $(ecr_image) ./service/

push-remote: ecr-login
	docker push $(ecr_image)

create-repo:
	terraform -chdir=infra/ecr-repository apply -auto-approve

show-repo:
	@echo $(ecr_image)

show-hostname:
	@command kubectl get svc -n mwalter-url-shortener mwalter-url-shortener -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

bootstrap: check-tools create-repo build-remote push-remote

teardown:
	aws ecr delete-repository --repository-name mwalter-test-pw --force
	terraform -chdir=infra/ecr-repository destroy -auto-approve
	kubectl delete ns mwalter-url-shortener mwalter-redis

install-redis:
	helm template --release-name mwalter --set namespaceOverride=mwalter-redis --set auth.enabled=false oci://registry-1.docker.io/bitnamicharts/redis > infra/redis/resources.yaml
	kubectl kustomize infra/redis | kubectl apply -f -
	@command rm -f infra/redis/resources.yaml

install-app:
	kubectl kustomize infra/url-shortener | kubectl apply -f -

converge: install-redis install-app

test:
	@command kubectl get svc -n mwalter-url-shortener mwalter-url-shortener -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' > hostname.txt
	@command ./scripts/smoketest.sh $$(cat hostname.txt)
	@command rm hostname.txt
