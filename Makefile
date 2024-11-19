# Makefile for building, pushing Docker images and deploying with Terraform
# .PHONY is used to declare that these targets do not represent actual files
.PHONY: build-images push-images deploy clean clean-all

# Variables for Docker registry and versioning
DOCKER_REGISTRY=<your-registry>
VERSION=1.0.2
FRONTEND_IMAGE=$(DOCKER_REGISTRY)/frontend:$(VERSION)
BACKEND_IMAGE=$(DOCKER_REGISTRY)/backend:$(VERSION)

# Target to clean existing containers and images
clean:
	# Remove existing containers if they exist
	docker ps -a | grep "$(FRONTEND_IMAGE)" | awk '{print $$1}' | xargs -r docker rm -f
	docker ps -a | grep "$(BACKEND_IMAGE)" | awk '{print $$1}' | xargs -r docker rm -f
	# Remove existing images if they exist
	docker images | grep "$(DOCKER_REGISTRY)/frontend" | awk '{print $$3}' | xargs -r docker rmi -f
	docker images | grep "$(DOCKER_REGISTRY)/backend" | awk '{print $$3}' | xargs -r docker rmi -f

# Target to clean all related Docker resources
#clean-all: clean
#Remove all dangling images and build cache
#docker system prune -f

# Target to build Docker images for frontend and backend
build-images: clean
	# Build the frontend Docker image
	docker build -t $(FRONTEND_IMAGE) frontend/
	# Build the backend Docker image
	docker build -t $(BACKEND_IMAGE) backend/

# Target to push Docker images to the specified registry
push-images:
	# Push the frontend Docker image to the registry
	docker push $(FRONTEND_IMAGE)
	# Push the backend Docker image to the registry
	docker push $(BACKEND_IMAGE)

# Target to deploy infrastructure and applications using Terraform
deploy:
	# Navigate to the Terraform directory, initialize, and apply the configuration
	cd terraform && terraform init && terraform apply -auto-approve

# Target to do everything in sequence
all: clean build-images push-images deploy

# Target to destroy all resources and clean up
destroy:
	# Destroy Terraform resources
	cd terraform && terraform destroy -auto-approve
# Clean Docker resources
# $(MAKE) clean-all