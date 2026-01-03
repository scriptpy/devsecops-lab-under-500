# DigitalOcean Cloud VM Template

This is a ready-to-use Terraform template for creating a VM (droplet) on DigitalOcean.

## Prerequisites

1. DigitalOcean account with API token
2. Terraform installed (already done!)
3. SSH key added to DigitalOcean (optional, for SSH access)

## How to Use (When You Have Cloud Access)

### Step 1: Get Your DigitalOcean API Token

1. Log in to DigitalOcean
2. Go to API → Tokens/Keys
3. Generate a new token
4. Copy the token (you'll need it in Step 3)

### Step 2: Create a `.tfvars` File

Create a file called `terraform.tfvars` in this folder:

```hcl
do_token     = "your-api-token-here"
region       = "nyc1"  # or your preferred region
droplet_size = "s-1vcpu-1gb"  # smallest/cheapest option
```

**Important:** Add `terraform.tfvars` to `.gitignore` - never commit your API token!

### Step 3: Initialize Terraform

```powershell
terraform init
```

This downloads the DigitalOcean provider.

### Step 4: Preview What Will Be Created

```powershell
terraform plan
```

Review what Terraform will create.

### Step 5: Create the VM

```powershell
terraform apply
```

Type `yes` when prompted. This will:
- Create a Ubuntu 22.04 VM
- Show you the IP address when done

### Step 6: Access Your VM

After `terraform apply` completes, you'll see the IP address in the outputs:

```
Outputs:
vm_ip = "123.456.789.0"
```

You can SSH into it (if you added SSH keys) or use the DigitalOcean console.

### Step 7: Clean Up (When Done)

```powershell
terraform destroy
```

This deletes the VM and stops billing.

## Variables Explained

- `do_token`: Your DigitalOcean API token (required, sensitive)
- `region`: Where to create the VM (default: nyc1)
  - Options: nyc1, nyc3, sfo3, ams3, sgp1, etc.
- `droplet_size`: VM size (default: s-1vcpu-1gb - smallest/cheapest)
  - Options: s-1vcpu-1gb ($6/mo), s-1vcpu-2gb ($12/mo), etc.

## Cost Estimate

- Smallest droplet: ~$6/month (~$0.01/hour)
- With $200 free credit: ~33 months free!

## Notes

- The `ssh_keys = []` is empty - you'll need to add your SSH key ID later for passwordless SSH
- This creates a basic VM - you can add firewall rules, volumes, etc. later
- Always run `terraform destroy` when done to avoid unexpected charges

## Next Steps (Future Enhancements)

- Add firewall rules via Terraform
- Configure SSH keys automatically
- Add block storage volumes
- Set up monitoring/alerts

