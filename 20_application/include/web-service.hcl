service {
  name = "web"
  id = "web-1"
  port = 8080

  connect {
    sidecar_service {}
  }

  check {
    name = "HTTP Health Check"
    http = "http://localhost:8080/health"
    interval = "10s"
  }
}