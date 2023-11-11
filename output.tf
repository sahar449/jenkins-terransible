output "prometheus" {
  value = join(":", [aws_instance.prometheus.public_ip, 9090])
}

output "grafana" {
  value = join(":", [aws_instance.grafana.public_ip, 3000])
}

