output "ec2_public_dns" {
  description = "EC2 instance Public DNS"
  value       = aws_instance.Jenkin-lab.public_dns
  #sensitive   = true
}

output "ec2_public_ip" {
  description = "EC2 instance Public IP"
  value       = aws_instance.Jenkin-lab.public_ip
  #sensitive   = true
}
