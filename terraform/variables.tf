variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "ops-team"
}

variable "frontend_image" {
  description = "Frontend container image"
  type        = string
  default     = "<your-registry>/frontend:1.0.2"
}

variable "backend_image" {
  description = "Backend container image"
  type        = string
  default     = "<your-registry>/backend:1.0.2"
}