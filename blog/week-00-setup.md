# Week 0: Sprint 0 - Hardware Sourcing & Platform Setup

Date: 14/12/2025

So this is Week 0 of my $500 DevSecOps pipeline project. Basically just setting everything up - creating the repo, figuring out how I'm going to publish this stuff, and buying the hardware I need.

## What I'm trying to do

The goal is to build a complete DevSecOps pipeline using old hardware and stay under $500. I want to document everything in blog posts, learn the tools hands-on, and end up with something I can show employers. Skills I'll be learning: Terraform, Docker, CI/CD, security hardening, observability stuff.

Main goal is to learn and have something concrete to put on my CV instead of just certifications.

## What I did this week

### Repository Setup

Created the GitHub repo structure with folders for blog posts, infrastructure code, security configs, etc. Set up README, .gitignore, and a basic publishing workflow. 

Repo is at: https://github.com/scriptpy/devsecops-lab-under-500.git

### Budget Tracker

Made a budget tracker in docs/budget.md. Started with $500 budget, but already spent $445 on hardware. Only $55 left, but cloud services will use free credits so should be okay.

### Publishing Workflow

Figured out I'll publish on GitHub Pages, cross-post to Medium, and share on LinkedIn. Made a checklist so I actually do it each week.

### Hardware

Lab laptop: Bought a used ThinkPad 495 Office Edition for $210. Has 500GB SSD and 8GB RAM, should be enough for Kali Linux. Found it locally, ThinkPads are reliable so went with it.

![Laptop specs](assets/images/week%200/laptop%20specs.jpeg)

Android devices: Ended up buying three phones - OnePlus 7 Pro ($60, has screen burn and a crack but works), Honor P 70 Lite ($50), and Redmi A3 ($50). The OnePlus will be the main one for NetHunter since it's the most capable. The other two are backups. Probably overkill but whatever.

![Phones and cables](assets/images/week%200/phones%20and%20cables.jpeg)

Cloud VM: Haven't decided yet. Options are DigitalOcean ($200 free credit), Linode ($100 free), or Oracle Cloud (always free). Will figure it out in Week 3 when I actually need it. Probably DigitalOcean for the bigger credit.

Other stuff: USB charging station ($40) - seemed useful for managing all these devices. Cables ($10). Two USB sticks - 64GB and 128GB SanDisk ($25 total) for Kali installation and backups.

![Docking station](assets/images/week%200/docking%20station.jpeg)

![Phone docking station](assets/images/week%200/phone%20docking%20station.jpeg)

![Docked phones charging](assets/images/week%200/docked%20phones%20charging.jpeg)

![USB stick](assets/images/week%200/usb.jpeg)

## Challenges

Didn't really run into any major issues. Setting up the repo structure was straightforward, GitHub setup was fine. Main thing was deciding on hardware and staying in budget - went way over on hardware ($445 instead of $150), but cloud will use free credits so should still be under $500 total.

## What I learned

Planning ahead helps - setting up the folder structure and docs templates now makes things easier later. 

Budget can change - planned $150 for hardware, spent $445. ThinkPad cost more than expected, and buying multiple phones added up. Good thing cloud has free credits.

Setting up the budget tracker and publishing workflow from the start means I'll actually use them. If I waited, I'd probably forget to track expenses.

## Next week

Week 1 is installing and hardening Kali Linux on the ThinkPad. Need to set up SSH keys, configure firewall, create AppArmor profiles, and document it all in a runbook.

## Links

- Project repo: https://github.com/scriptpy/devsecops-lab-under-500
- Budget tracker: docs/budget.md
- Publishing workflow: PUBLISHING.md

## Wrap up

Week 0 done. Got the structure set up, bought the hardware, budget tracked. Ready to start the actual technical work next week.

Time spent: About 4-5 hours (structure setup, hardware research, shopping)  
Cost this week: $445  
Total so far: $445

Next: Week 1 - Installing & Hardening Kali Linux

---

Note: I used AI (ChatGPT) as a research tool for this project - basically like Google but better for learning and organizing ideas. All decisions and content are mine, but AI helped me learn faster. Being transparent about using modern tools.

