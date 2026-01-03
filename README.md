# The $500 DevSecOps Pipeline

Building a DevSecOps pipeline using old hardware, staying under $500. Documenting the whole thing in blog posts as I go.

Goal: Build a complete pipeline (Kali Linux, Android tools, cloud VM, Docker, CI/CD) and learn the skills hands-on. End result should be something I can show employers instead of just certifications.

## 12-Week Schedule

| Week | Chapter Title | Core Skill | Key Output |
|------|----------------|------------|------------|
| 0 | Sprint 0: Hardware Sourcing & Platform Setup | GitHub repo init, budget sheet, publish workflow | Repo created, first "Sprint 0" blog post |
| 1 | Installing & Hardening Kali on Lab Laptop | OS install, SSH-key only, ufw/AppArmor hardening | Hardened Kali VM + Runbook entry |
| 2 | Creating a Mobile Security Hub (NetHunter + Termux) | Bootloader unlock, install NetHunter, Python agent | Mobile agent script (log collector) |
| 3 | IaC Foundation: Terraform on Cheap Cloud VM | Write Terraform to provision DO/Linode VM, set billing alerts | Cloud VM live, cost-alert configured |
| 4 | Building the Agent (Python/Bash log collector) | Secure secret handling (dotenv+gpg), pre-commit hook | Agent script + security folder |
| 5 | Securing the Telemetry (Encrypted Transport) | TLS/HTTPS or WireGuard tunnel between agents & cloud | Encrypted log pipeline diagram |
| 6 | Containerizing the Log Backend (Docker) | Dockerfile, non-root user, read-only FS, capability drops | Docker image pushed to Docker Hub |
| 7 | Automating Deployment (GitHub Actions CI/CD) | Build → Test → Deploy workflow, Terraform apply from pipeline | CI pipeline badge live |
| 8 | Observability Layer (Loki + Grafana) | Push logs to Loki, view in Grafana dashboard | Real-time log dashboard |
| 9 | Security Validation & MITRE ATT&CK Mapping | Run vulnerability scan (Trivy), audit firewall, map attack steps | Security-audit report + ATT&CK mapping |
| 10 | Incident-Response Drill & Forensics | Simulate breach, triage with logs, write incident report | Incident-response playbook |
| 11 | Final Review & The DevSecOps Blueprint | Compile architecture diagram, cost breakdown, Runbook, publish series | Completed series URL + LinkedIn posts |

> **Note:** Week 2 (NetHunter) is optional. If Android setup is challenging, use a VM-based alternative to keep momentum.

## Budget

See docs/budget.md for cost tracking. Currently at $445 spent, $55 remaining. Goal is under $500 total.

## Project Structure

```
devsecops-lab-under-500/
├─ .github/workflows/     # GitHub Actions CI/CD
├─ .infra/terraform/      # Infrastructure as Code
├─ blog/                  # Weekly blog posts
├─ infra/                 # Runtime infrastructure (Dockerfiles, etc.)
├─ security/              # Security configs, hardening, secrets management
├─ assets/images/         # Screenshots, diagrams, photos
└─ docs/                  # Documentation, budget tracker, runbooks
```

## Getting Started

Week 0, Week 1, Week 2, and Week 3 are done - repo set up, hardware bought, Kali Linux installed and hardened, NetHunter installed on OnePlus 7 Pro, Terraform learned locally with cloud-ready templates created. Week 4 is next - building the log collector agent.

## Blog Posts

- [Week 0: Sprint 0 - Hardware Sourcing & Platform Setup](blog/week-00-setup.md)
- [Week 1: Installing & Hardening Kali Linux](blog/week-01-install.md)
- [Week 2: Creating a Mobile Security Hub (NetHunter + Termux)](blog/week-02-nethunter.md)
- [Week 3: Infrastructure as Code with Terraform](blog/week-03-iac.md)

## Skills I'm Learning

- Infrastructure as Code (Terraform)
- CI/CD (GitHub Actions)
- Container Security (Docker hardening, Trivy scans)
- OS & Application Hardening (ufw, AppArmor, secrets management)
- Observability (Loki + Grafana)
- Incident Response & MITRE ATT&CK mapping
- Network Security & Encrypted Transport
- Python/Bash Scripting
- Linux System Administration

## License

This project is licensed under the GNU General Public License v3.0 (GPL-3.0).

See [LICENSE](LICENSE) file for full license text and disclaimer.

**Important:** This project is for educational purposes only. Users are responsible for ensuring their use complies with all applicable laws. Unauthorized access to computer systems is illegal.

---

Status: Week 3 complete, ready for Week 4

