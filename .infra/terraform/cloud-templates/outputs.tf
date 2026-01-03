output "vm_ip" {
  description = "Public IP address of the VM"
  value       = digitalocean_droplet.vm.ipv4_address
}

output "vm_id" {
  description = "ID of the created droplet"
  value       = digitalocean_droplet.vm.id
}