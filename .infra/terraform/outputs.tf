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