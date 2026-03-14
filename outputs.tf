output "network_name" {
  description = "Created Docker network name."
  value       = docker_network.lab.name
}

output "container_name" {
  description = "Created Docker container name."
  value       = docker_container.web.name
}

output "redis_container_name" {
  description = "Created Redis container name."
  value       = docker_container.redis.name
}

output "application_url" {
  description = "URL exposed by local Docker host."
  value       = "http://localhost:${var.nginx_port}"
}
