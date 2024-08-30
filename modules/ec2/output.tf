output "app_server1" {
  value = aws_instance.app_server1.id
}

output "app_server2" {
  value = aws_instance.app_server2.id
}

output "app_server1_name" {
  value = aws_instance.app_server1.tags["Name"]
}

output "app_server2_name" {
  value = aws_instance.app_server2.tags["Name"]
}
