terraform { 
    required_version = ">=1.0"
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "~> 2.4"
        }
    random = {
        source = "hashicorp/random"
        version = "~> 3.5"
    }    
    }
}

provider "local" {}
provider "random"{}
resource "local_file" "hello" {
    filename = "output/hello.txt"
    content = var.message
}
resource "random_string" "password"{
    length = 16
    special = true
    upper= true
    lower = true
    numeric = true
}