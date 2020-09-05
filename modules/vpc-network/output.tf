output "network_ids" {
  description = "The IDs of the sub-networks in each of the AZs."
  value       = aws_subnet.net[*].id
}