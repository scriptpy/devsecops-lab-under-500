# Kali Lab Runbook

This runbook contains procedures for managing and accessing the Kali Linux lab environment.

## System Information

- **Hostname:** kali-lab
- **OS:** Kali Linux Rolling
- **Purpose:** DevSecOps lab environment

## SSH Access

### From Windows Machine

To SSH into the lab using key-based authentication:

```bash
ssh -i ~/.ssh/kali_lab_key <username>@<kali-ip-address>
```

Replace:
- `<username>` with your Kali username
- `<kali-ip-address>` with the lab's IP address

### Verify SSH Key Authentication

SSH is configured for key-only authentication. Password authentication is disabled.

## Firewall Management

### Check Firewall Status

```bash
sudo ufw status verbose
```

### View Firewall Rules

```bash
sudo ufw status numbered
```

### Add Firewall Rule

```bash
sudo ufw allow <port>/<protocol>
# Example: sudo ufw allow 80/tcp
```

### Disable Firewall (if needed)

```bash
sudo ufw disable
```

### Enable Firewall

```bash
sudo ufw enable
```

## AppArmor Status

### Check AppArmor Status

```bash
sudo aa-status
```

### View SSH Profile

```bash
sudo aa-status | grep sshd
```

### Reload AppArmor Profile

```bash
sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.sshd
```

## System Services

### List Running Services

```bash
systemctl list-units --type=service --state=running
```

### List Enabled Services

```bash
systemctl list-unit-files | grep enabled
```

### Disable a Service

```bash
sudo systemctl disable <service-name>
sudo systemctl stop <service-name>
```

## Network Information

### Get IP Address

```bash
ip a
# or
hostname -I
```

### Check Network Connectivity

```bash
ping -c 4 8.8.8.8
```

## System Updates

### Update Package Lists

```bash
sudo apt update
```

### Upgrade System

```bash
sudo apt upgrade -y
```

### Install Package

```bash
sudo apt install <package-name> -y
```

## Backup and Recovery

### Create System Snapshot (if using VM)

If running in a VM, create snapshots before major changes.

### Backup Important Configs

```bash
# Backup SSH config
sudo cp /etc/ssh/sshd_config ~/backups/

# Backup firewall rules
sudo ufw status numbered > ~/backups/ufw_rules.txt

# Backup AppArmor profiles
sudo cp /etc/apparmor.d/usr.sbin.sshd ~/backups/
```

## Troubleshooting

### SSH Connection Issues

1. Verify firewall allows SSH: `sudo ufw status`
2. Check SSH service is running: `sudo systemctl status ssh`
3. Verify SSH key permissions: `chmod 600 ~/.ssh/authorized_keys`

### Firewall Blocking Access

1. Check firewall status: `sudo ufw status verbose`
2. Temporarily disable to test: `sudo ufw disable`
3. Re-enable after troubleshooting: `sudo ufw enable`

### AppArmor Issues

1. Check profile status: `sudo aa-status`
2. Check logs: `sudo dmesg | grep apparmor`
3. Reload profile if needed: `sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.sshd`

---

**Last Updated:** Week 1  
**Next Review:** As needed

