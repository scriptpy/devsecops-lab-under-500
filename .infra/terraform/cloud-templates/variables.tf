variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean region (e.g., nyc1, sfo3, ams3)"
  type        = string
  default     = "nyc1"
}

variable "droplet_size" {
  description = "Droplet size slug (e.g., s-1vcpu-1gb for smallest)"
  type        = string
  default     = "s-1vcpu-1gb"
}