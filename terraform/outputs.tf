output "frontend_url" {
  value = "http://$(minikube ip):${kubernetes_service.frontend.spec[0].port[0].node_port}"
}

output "namespace" {
  value = kubernetes_namespace.exercise.metadata[0].name
}