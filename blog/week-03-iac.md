# Week 3: Infrastructure as Code with Terraform

Date: 01/01/2026

Week 3 is done. Learned Terraform and Infrastructure as Code (IaC). Was supposed to provision a cloud VM, but hit some payment method issues, so ended up learning Terraform locally first. Turned out to be a good approach - got the fundamentals down before dealing with cloud providers.

## What I did this week

### The Plan vs Reality

Original plan was to sign up for a cloud provider (DigitalOcean or Oracle Cloud), provision a VM with Terraform, set up billing alerts, the whole thing. But ran into issues with payment methods - my Monese card wasn't accepted by DigitalOcean, and Oracle Cloud signup was a mess. Couldn't get either to work.

Decided to pivot: learn Terraform locally first, understand the concepts, then deploy to cloud later when I sort out the payment stuff. This actually worked out better - got to focus on learning without worrying about cloud costs or account issues.

### Installing Terraform

Downloaded Terraform 1.14.3 for Windows. It's just a single executable file - extract it, add to PATH, done. Verified it worked with `terraform version`. Pretty straightforward.

### Learning the Basics

Started with understanding what Infrastructure as Code even means. Instead of clicking buttons in a web UI to create servers, you write code that describes what you want. Terraform reads that code and creates the infrastructure. Like a recipe for servers.

Terraform uses HCL (HashiCorp Configuration Language). It's not a programming language - you're not writing step-by-step instructions. You're describing what you want, and Terraform figures out how to make it happen.

### My First Terraform File

Created a simple `main.tf` file with the local provider. The local provider lets you create files on your computer - good for learning without needing cloud access.

Started with a basic structure:
- Terraform block (says what providers you need)
- Provider block (configures the provider)
- Resource block (what you want to create)

Created a simple file resource that writes "Hello from Terraform!" to a text file. Ran `terraform init` to download the provider, `terraform plan` to see what it would do, then `terraform apply` to actually create it. It worked! The file appeared in the output folder.

![Output file created](/devsecops-lab-under-500/assets/images/week%203/output%20file%20applied.png)

![First Terraform init](/devsecops-lab-under-500/assets/images/week%203/first%20terraform%20%20.png)

![Terraform plan output](/devsecops-lab-under-500/assets/images/week%203/terraform%20plan.png)

![Terraform apply output](/devsecops-lab-under-500/assets/images/week%203/terraform%20apply.png)

### Learning Variables

Next learned about variables. Instead of hardcoding values in your config, you put them in a separate `variables.tf` file. Makes your code reusable - change the variable value, don't edit the main code.

Created a `message` variable with a default value. Then updated my file resource to use `var.message` instead of hardcoded text. Ran `terraform apply` again - Terraform detected the change and updated the file. Pretty cool how it tracks what changed.

![Terraform plan with variable](/devsecops-lab-under-500/assets/images/week%203/terraform%20var.message%20plan.png)

![Terraform apply with variable](/devsecops-lab-under-500/assets/images/week%203/terraform%20var.message%20applied.png)

### Learning Outputs

Outputs let Terraform show you information after it creates resources. Created an `outputs.tf` file that shows the file path and content. After running `terraform apply`, it displays the outputs at the end. Useful for seeing what was created.

Also learned about sensitive outputs - if you mark an output as `sensitive = true`, Terraform hides the value in the console. Good for passwords and secrets.

### Trying the Random Provider

Added the random provider to generate random values. Created a `random_string` resource that generates a 16-character password with special characters, uppercase, lowercase, and numbers. Used it in an output marked as sensitive.

![Terraform init with random provider](/devsecops-lab-under-500/assets/images/week%203/terraform%20innit%20with%20added%20random%20provider.png)

![Terraform plan with random provider](/devsecops-lab-under-500/assets/images/week%203/terraform%20plan%20aftert%20adding%20random.png)

![Terraform apply with random password](/devsecops-lab-under-500/assets/images/week%203/terraform%20apply%20after%20random.png)

This showed me how to use multiple providers in the same configuration. Terraform handles downloading and managing them all.

### The HCL Syntax Lesson

Made a mistake with HCL syntax. Added a comma between provider definitions in the `required_providers` block. Terraform gave me an error - "Unexpected comma after argument". 

Turns out HCL doesn't use commas between items in blocks. Items are just separated by newlines. Fixed it, and it worked. Good lesson - HCL is different from JSON or other config languages.

### Learning terraform destroy

Ran `terraform destroy` to see how to clean everything up. It showed what would be deleted, asked for confirmation, then removed all the resources. The file was gone, the random password resource was gone. Complete lifecycle: create, update, destroy.

![Terraform destroy output](/devsecops-lab-under-500/assets/images/week%203/terraform%20destroy.png)

### Creating Cloud-Ready Templates

Even though I couldn't deploy to cloud yet, created ready-to-use templates for when I get cloud access. Set up a DigitalOcean droplet template with:
- Provider configuration
- Variables for API token, region, VM size
- The actual VM resource
- Outputs for IP address and ID
- A README with instructions

When I finally get cloud access, I can just add my API token and run `terraform apply`. The template is ready to go.

## Challenges

### Payment Method Issues

Tried Oracle Cloud first - signup process was broken, couldn't complete registration. Switched to DigitalOcean, but my Monese card wasn't accepted. Both cloud providers blocked by payment issues.

Solution: Learned Terraform locally instead. Actually better for understanding the fundamentals.

### HCL Syntax Confusion

Added a comma between provider definitions, thinking it was like JSON. Terraform threw an error. Learned that HCL uses newlines, not commas, to separate items in blocks.

### Understanding the Workflow

At first wasn't sure why you need `terraform init` every time, or what `terraform plan` was for. After using it a few times, it clicked:
- `init` downloads providers
- `plan` shows you what will change (safety check)
- `apply` actually creates/updates resources
- `destroy` removes everything

The workflow makes sense now.

## What I learned

### Infrastructure as Code Concepts

IaC is powerful. Instead of manually creating servers, you write code. That code can be version controlled, reviewed, shared. Same code creates the same infrastructure every time. No more "works on my machine" - if the code works, the infrastructure works.

### Terraform Workflow

The init → plan → apply workflow is important. Always run `plan` first to see what will change. Prevents surprises. The `destroy` command is useful for cleanup, but also dangerous - double check before running it.

### Variables and Outputs

Variables make code reusable. Outputs show you what was created. Both are essential for real-world Terraform usage. Sensitive outputs are important for security - don't want passwords showing in console output.

### Multiple Providers

Terraform supports tons of providers - local files, random values, cloud providers, databases, everything. You can use multiple providers in the same configuration. The provider system is flexible.

### Learning Locally First

Learning Terraform locally before deploying to cloud was actually a good approach. Got the fundamentals down without worrying about:
- Cloud account setup
- Payment methods
- Billing concerns
- Network issues

When I do deploy to cloud, I'll understand what Terraform is doing, not just following a tutorial.

## Terraform Limitations (What I Noticed)

### State Management

Terraform tracks what it created in a `.tfstate` file. This file is important - if you lose it, Terraform doesn't know what resources exist. Need to back it up or use remote state for team environments.

### No Rollback

If `terraform apply` fails partway through, Terraform doesn't automatically roll back. You might end up with partial infrastructure. Need to manually clean up or fix the issue and try again.

### Learning Curve

HCL syntax is different from other config languages. The workflow (init, plan, apply) takes getting used to. But once you get it, it's pretty intuitive.

## Next week

Week 4 is about building the agent - a Python/Bash script that collects logs and metrics. This will run on both the Kali laptop and eventually the phone/VM. Need to learn about secure secret handling, GPG encryption, and pre-commit hooks to prevent secrets from being committed to Git.

## Links

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Providers](https://registry.terraform.io/browse/providers)
- [DigitalOcean Provider Docs](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)

## Wrap up

Week 3 was about learning Infrastructure as Code with Terraform. Didn't deploy to cloud yet, but got the fundamentals down. Created working examples locally, learned the workflow, and prepared templates for future cloud deployment.

The payment method issues were frustrating, but learning locally first turned out to be a better approach. When I do get cloud access, I'll understand what Terraform is doing, not just copying code.

Terraform is powerful. Writing infrastructure as code feels like the right way to do things. Version controlled, repeatable, documented. Looking forward to actually deploying to cloud in the future.

Total cost this week: $0 (all learning done locally, Terraform is free).

Next: Week 4 - Building the Agent (Python/Bash log collector)

---

Note: I used AI (ChatGPT) as a research tool for this project - basically like Google but better for learning and organizing ideas. All decisions and content are mine, but AI helped me learn faster. Being transparent about using modern tools.

