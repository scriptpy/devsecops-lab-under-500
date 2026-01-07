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

output "file_path" {
    description = "Path to the file created"
    value = local_file.hello.filename
}

output "file_content" {
    description = "Content of the file created"
    value = local_file.hello.content
    sensitive = false
}

output "generated_password" {
    description = "Randomly generated password"
    value = random_string.password.result
    sensitive = true
}