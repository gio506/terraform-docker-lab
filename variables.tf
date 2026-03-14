variable "project_name" {
  description = "Prefix used for Docker resource names."
  type        = string
  default     = "terraform-docker-lab"
}

variable "container_name" {
  description = "Name of the demo web container."
  type        = string
  default     = "lab-nginx"
}

variable "redis_container_name" {
  description = "Name of the Redis sidecar container."
  type        = string
  default     = "lab-redis"
}

variable "nginx_port" {
  description = "Host port mapped to container port 80."
  type        = number
  default     = 8080
}

variable "welcome_message" {
  description = "Text rendered by the demo container as index.html."
  type        = string
  default     = "Hello from Terraform Docker Lab"
}

variable "app_environment" {
  description = "Environment label passed into the container."
  type        = string
  default     = "local-dev"
}
