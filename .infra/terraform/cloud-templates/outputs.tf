# Copyright (C) 2026  G A Istrati
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# This project is for educational purposes only. Users are responsible for
# ensuring their use complies with all applicable laws.
#

output "vm_ip" {
  description = "Public IP address of the VM"
  value       = digitalocean_droplet.vm.ipv4_address
}

output "vm_id" {
  description = "ID of the created droplet"
  value       = digitalocean_droplet.vm.id
}