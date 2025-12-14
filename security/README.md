# Security Configuration

This directory contains all security-related configurations, hardening scripts, and security tools.

## Directory Structure

- `hardening/` - OS and application hardening configurations
  - `ufw.rules` - Firewall rules (Week 1)
  - `apparmor.profile` - AppArmor profiles (Week 1)
  - `docker-secure.Dockerfile` - Hardened Docker configuration (Week 6)
  - `trivy-report.html` - Vulnerability scan reports (Week 9)

- `secrets/` - Secrets management
  - `.env.example` - Environment variable template
  - `.env` - Actual secrets (NOT committed to git)

- `pre-commit/` - Git hooks for security
  - `gitleaks-hook.sh` - Pre-commit hook to prevent secret leaks (Week 4)

## Security Best Practices

1. **Never commit secrets** - Use `.env` files and GPG encryption
2. **Use pre-commit hooks** - Prevent accidental secret commits
3. **Scan containers** - Use Trivy to scan Docker images
4. **Hardening** - Apply OS and application hardening from the start
5. **Least privilege** - Run containers and services with minimal permissions

