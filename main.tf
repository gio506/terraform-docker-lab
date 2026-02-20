resource "docker_network" "lab" {
  name = "${var.project_name}-network"
}

resource "docker_volume" "nginx_data" {
  name = "${var.project_name}-data"
}

resource "docker_image" "nginx" {
  name         = "nginx:1.27-alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = var.container_name
  image = docker_image.nginx.image_id

  env = [
    "APP_ENV=${var.app_environment}",
    "WELCOME_MESSAGE=${var.welcome_message}"
  ]

  networks_advanced {
    name = docker_network.lab.name
  }

  mounts {
    target = "/usr/share/nginx/html"
    source = docker_volume.nginx_data.name
    type   = "volume"
  }

  ports {
    internal = 80
    external = var.nginx_port
  }

  command = [
    "sh",
    "-c",
    "printf '<h1>%s</h1><p>Environment: %s</p>' \"$WELCOME_MESSAGE\" \"$APP_ENV\" > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
  ]

  restart = "unless-stopped"
}
