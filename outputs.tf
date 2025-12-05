output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.demo.id
}

output "public_ip" {
  description = "The public IPv4 address (if assigned)"
  value       = aws_instance.demo.public_ip
}

output "availability_zone" {
  description = "The availability zone where the instance is running"
  value       = aws_instance.demo.availability_zone
}
