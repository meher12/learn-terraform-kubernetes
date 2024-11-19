# Terraform & Kubernetes(Minikube) Application Deployment


## Key Features:
1. Infrastructure as Code with Terraform
2. Kubernetes resource management
3. Multi-tier application deployment
4. Service discovery and networking


### 1. Ensure you have the following prerequisites:
   - Minikube installed and running
   - Terraform installed
   - kubectl configured for Minikube


### 2. The infrastructure includes:
   - Separate namespace for isolation
   - Frontend deployment with NodePort service (accessible from outside)
   - Backend deployment with ClusterIP service (internal only)
   - ConfigMap for configuration
   - Resource limits and requests
   - Multiple replicas for high availability

### 3. Project Structure
```
.
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   ├── src/
│   │   └── App.js
│   └── nginx.conf
├── backend/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── app.py
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── kubernetes.tf
│   └── outputs.tf
└── Makefile
```


**NB:** Replace `your-registry` in the Makefile and variables.tf with your Docker registry (e.g., your Docker Hub username)

##### 3.1. Build the Docker images locally:
```bash
make build-images
```

##### 3.2 Push the images to your registry:
```bash
# First login to your registry
docker login

# Then push the images
make push-images
```

##### 3.3 Deploy to Kubernetes:
```bash
make deploy
```

The setup includes:
- A simple React frontend
- A Flask backend API
- Nginx configuration for the frontend
- Docker configurations for both services
- Makefile for easy building and deployment

To test locally before deploying to Kubernetes:
```bash
# Build and run frontend
cd frontend
docker build -t frontend .
docker run -p 80:80 frontend

# Build and run backend
cd backend
docker build -t backend .
docker run -p 8080:8080 backend
```
