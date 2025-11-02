output "region1_instance_ip" {
  value = module.ec2_region1.public_ip
}

output "region2_instance_ip" {
  value = module.ec2_region2.public_ip
}
