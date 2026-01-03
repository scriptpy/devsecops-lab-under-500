# Week 3 - Infrastructure as Code (Terraform) Notes

## Current Status
- **Week:** 3
- **Goal:** Provision a cloud VM using Terraform (Infrastructure as Code)
- **Core Skill:** Terraform, cloud infrastructure provisioning
- **Key Output:** Cloud VM live, cost alerts configured, infrastructure documented as code

## Learning Objectives
1. Understand what Infrastructure as Code (IaC) is and why it's important
2. Learn Terraform basics (HCL syntax, providers, resources)
3. Provision a cloud VM using Terraform
4. Configure firewall rules via code
5. Set up SSH key-based authentication
6. Configure billing alerts

## Decisions Made
- **Cloud Provider:** Learning locally first (switched from DigitalOcean due to card issues)
- **Reason:** Learn Terraform concepts, syntax, and workflow without cloud provider. Can deploy to cloud later when payment method is available.
- **Approach:** Use Terraform with local provider and Docker provider to learn IaC concepts
- **VM Size:** N/A (learning locally)
- **Region:** N/A (learning locally)

## Installation Steps

### Step 1: Choose Cloud Provider
- [x] Research cloud provider options
- [x] Compare free credits and pricing
- [x] Make decision based on budget and needs - **DECIDED: Learn locally first**
- [x] Understand why learning locally is valuable (concepts before deployment)

### Step 2: Set Up Billing Alerts
- [ ] **SKIPPED** - Learning locally, no billing needed
- [ ] Will set up billing alerts when deploying to cloud later

### Step 3: Install Terraform
- [x] Download Terraform for Windows - **COMPLETE** (terraform_1.14.3_windows_amd64.zip)
- [x] Extract Terraform ZIP file - **COMPLETE**
- [x] Verify installation (`terraform version`) - **COMPLETE** (v1.14.3)
- [x] Add Terraform to PATH - **COMPLETE**

### Step 4: Learn Terraform Basics
- [x] Understand HCL (HashiCorp Configuration Language) syntax - **LEARNED**
- [x] Learn about providers, resources - **LEARNED** (local provider, local_file resource, random provider)
- [x] Review Terraform workflow (init, plan, apply, destroy) - **COMPLETED** (all commands learned!)
- [x] Learn about variables - **COMPLETED** (created variable, used var.message in main.tf)
- [x] Learn about outputs - **COMPLETED** (created outputs, learned sensitive outputs)

### Step 5: Write Terraform Configuration (Local Learning)
- [x] Create `.infra/terraform/` directory structure - **COMPLETE**
- [x] Write `main.tf` (local provider examples) - **COMPLETE** (created hello.txt file using variables)
- [x] Write `variables.tf` (learn variable syntax) - **COMPLETE** (created message variable)
- [x] Write `outputs.tf` (learn output syntax) - **COMPLETE** (created outputs, including sensitive output)
- [x] Create examples with local_file, random resources - **COMPLETE** (local_file and random_string)
- [x] Learn Terraform workflow (init, plan, apply, destroy) - **COMPLETE**

### Step 6: Learn Terraform Concepts (Local)
- [x] Understand providers (local, random, etc.) - **COMPLETE** (used both providers)
- [x] Learn resource syntax - **COMPLETE**
- [ ] Learn data sources - **SKIPPED** (advanced topic, not needed for basics)
- [x] Practice with local_file resource - **COMPLETE**
- [x] Practice with random resources - **COMPLETE** (random_string.password)
- [x] Understand state management - **LEARNED** (saw .tfstate, understand how Terraform tracks resources)

### Step 7: Advanced Local Examples
- [x] Create multiple resources - **COMPLETE** (local_file and random_string)
- [x] Use variables and outputs - **COMPLETE**
- [x] Learn about dependencies - **LEARNED** (Terraform handles dependencies automatically)
- [x] Practice terraform destroy - **COMPLETE** (destroyed all resources)
- [x] Understand state files - **LEARNED** (saw .tfstate file, understand tracking)

### Step 8: Prepare for Cloud Deployment
- [x] Document what we learned - **COMPLETE** (blog post written)
- [x] Create cloud-ready Terraform templates - **COMPLETE** (DigitalOcean template ready)
- [x] Understand what changes needed for cloud provider - **COMPLETE** (just need API token)
- [x] Note: Will deploy to cloud when payment method available - **DOCUMENTED**

## Challenges Encountered
- **Oracle Cloud signup failed:** Could not complete registration process. Switched to DigitalOcean as alternative.
- **DigitalOcean card issue:** Monese card not accepted by DigitalOcean. Need alternative provider or verification method.
- **GitHub Pages image paths:** Images not showing on GitHub Pages. Fixed by using absolute paths (`/devsecops-lab-under-500/assets/images/...`) instead of relative paths.

## Lessons Learned
- **HCL syntax:** No commas between items in blocks - items separated by newlines only
- **Variables make code reusable:** Can change values without editing main code
- **Outputs are useful:** Show important information after resources are created
- **Sensitive outputs:** Use `sensitive = true` for passwords/secrets
- **Multiple providers:** Can use multiple providers in same configuration
- **Terraform workflow:** init → plan → apply → destroy (complete lifecycle)
- **State management:** Terraform tracks what it created in .tfstate file
- **Learning locally first:** Good approach - understand concepts before cloud deployment

## Files Created
- `.infra/terraform/main.tf` - Main Terraform configuration
- `.infra/terraform/variables.tf` - Variable definitions
- `.infra/terraform/outputs.tf` - Output definitions
- `.infra/terraform/.gitignore` - Ignore sensitive files
- `docs/week-03-notes.md` - This file

## Time Spent
- **Total:** [To be updated]
- **Provider Selection:** [To be updated]
- **Terraform Learning:** [To be updated]
- **Configuration Writing:** [To be updated]
- **Testing & Troubleshooting:** [To be updated]
- **Blog Post:** [To be updated]

## Cost
- **Cloud Provider:** $0 (learning locally, no cloud needed)
- **Terraform:** Free (open source)
- **Total Week 3 Cost:** $0

## Next Steps
1. ✅ Choose cloud provider - **DONE** (learned locally)
2. ⏸️ Sign up and configure billing alerts - **DEFERRED** (payment method issues)
3. ✅ Install Terraform - **DONE**
4. ✅ Start learning Terraform basics - **DONE**
5. ✅ Write blog post - **DONE**
6. 🔄 Publish to GitHub Pages, Medium, LinkedIn - **IN PROGRESS**

