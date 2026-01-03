# Week 1: Installing & Hardening Kali Linux

Date: 20/12/2025

Week 1 is done. Installed Kali Linux on the ThinkPad and did some basic security hardening. Had a few hiccups during installation but got through it.

## What I did this week

### Installing Kali Linux

Started by downloading the Kali installer ISO from the official site. Used the installer image (not the live image) since I wanted to install it permanently on the ThinkPad.

![Kali installer download page](/devsecops-lab-under-500/assets/images/week%201/kali%20installer%20images.png)

Used Rufus on Windows to flash the 64GB USB stick. Rufus is straightforward - select the USB drive, choose the ISO, and click start. First issue - Windows Defender flagged a bunch of Kali files as threats. This is normal, Kali has penetration testing tools that antivirus software doesn't like. Had to allow the files or Defender would quarantine them.

![Rufus setup](/devsecops-lab-under-500/assets/images/week%201/rufus.png)

![USB being written](/devsecops-lab-under-500/assets/images/week%201/usb%20being%20written.png)

Booted from USB on the ThinkPad, went with "Graphical Install" option. The boot menu appeared and I selected the USB drive.

![Boot menu](/devsecops-lab-under-500/assets/images/week%201/1st%20boot%20menu.jpeg)

Installation started fine. Selected wireless network interface since I didn't have an Ethernet cable handy.

![Network configuration](/devsecops-lab-under-500/assets/images/week%201/network%20config.jpeg)

Chose "Guided - use entire disk" for partitioning to wipe Windows completely.

![Partitioning method](/devsecops-lab-under-500/assets/images/week%201/partition%20option.jpeg)

![Partition scheme](/devsecops-lab-under-500/assets/images/week%201/partitions.jpeg)

Confirmed the partition changes - this would wipe everything on the disk.

![Partition confirmation](/devsecops-lab-under-500/assets/images/week%201/partition%20confirm.jpeg)

Installation was going fine until it hit the software selection step - failed when trying to install the full desktop and tools. Tried a few times, kept failing.

![Software selection](/devsecops-lab-under-500/assets/images/week%201/software%20selection.jpeg)

![Installation error](/devsecops-lab-under-500/assets/images/week%201/install%20step%20failed.jpeg)

Workaround: Installed minimal system first (unchecked everything in software selection), then after installation completed, installed the full desktop and tools with `sudo apt install kali-linux-default -y`. This worked fine. Took about 30-40 minutes for the full install.

![Minimal install options](/devsecops-lab-under-500/assets/images/week%201/minimal%20options.jpeg)

![Minimal install complete](/devsecops-lab-under-500/assets/images/week%201/minimal%20install%20complete.jpeg)

After the minimal install, I updated the system and installed the full desktop environment.

![System updating](/devsecops-lab-under-500/assets/images/week%201/updating.jpeg)

Set hostname to `kali-lab` during installation. Used wireless connection since I didn't have an Ethernet cable handy.

### SSH Key-Only Authentication

Set up SSH so it only accepts key-based authentication, no passwords. Generated an SSH key pair on my Windows machine:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/kali_lab_key -C "kali-lab-key"
```

Copied the public key to Kali's `~/.ssh/authorized_keys` file, then modified `/etc/ssh/sshd_config` to disable password authentication:

- Changed `PasswordAuthentication yes` to `PasswordAuthentication no`
- Made sure `PubkeyAuthentication yes` was set
- Set `PermitRootLogin no` for security

Restarted SSH service. Now I can only access the lab via SSH key, which is more secure.

Here's the first login after installation:

![First Kali login](/devsecops-lab-under-500/assets/images/week%201/1st%20kali%20login.jpeg)

After getting the GUI working, here's the desktop menu:

![Kali desktop menu](/devsecops-lab-under-500/assets/images/week%201/1st%20kali%20menu.jpeg)

### Firewall (ufw)

Installed and configured ufw (Uncomplicated Firewall). Set it up with:

- Default deny incoming connections
- Default allow outgoing connections  
- Allowed SSH (port 22) so I can still access it

Basic setup but it works. Can always add more rules later if needed.

First sudo command to configure the firewall:

![First sudo command](/devsecops-lab-under-500/assets/images/week%201/1st%20sudo%20cmd.jpeg)

### AppArmor

Created an AppArmor profile for SSH to restrict what it can do. AppArmor is a Linux security module that limits what programs can access. Created a profile at `/etc/apparmor.d/usr.sbin.sshd` that restricts SSH's network access while still allowing it to function normally.

Loaded the profile and verified it's active. This adds another layer of security.

### Services

Checked what services were running and enabled. Decided to keep everything for now - didn't want to break anything by disabling services I might need later. Can always disable unnecessary ones later if needed.

## Challenges

**Windows Defender false positives:** Kali files got flagged as threats. Had to allow them or Defender would remove files from the USB. This is common when working with security tools on Windows.

**Installation errors:** Full desktop installation kept failing during the software selection step. Worked around it by installing minimal system first, then adding desktop and tools after. Took longer but it worked.

**GUI setup:** After installation, had to manually install and configure lightdm to get the desktop working. Not a big deal but took some troubleshooting. First boot showed no GUI, just command line.

![System reboot no GUI](/devsecops-lab-under-500/assets/images/week%201/system%20reboot%20no%20gui.jpeg)

After installing lightdm and the full desktop, got the GUI working.

**Time:** Installation and setup took longer than expected. Between troubleshooting installation issues, setting up GUI, and configuring security, probably spent 6-8 hours total.

## What I learned

Installation can be finicky - sometimes it's better to do minimal install first then add packages after. More reliable than trying to install everything at once.

Windows Defender will flag Kali tools - this is normal, not actual malware. Just security tools that can be used maliciously, so AV software gets nervous.

SSH key-only authentication is straightforward to set up and much more secure than passwords. Once it's working, you don't have to worry about brute force attacks.

ufw is simple to use - good for basic firewall needs. More complex rules can be added later if needed.

AppArmor profiles are useful but can be complex. Started with a basic profile for SSH, can expand later.

## Next week

Week 2 is setting up NetHunter on one of the Android phones. Need to unlock bootloader, install NetHunter, and set up Termux. This might be optional if it's too challenging - can use a VM alternative instead.

## Links

- Project repo: https://github.com/scriptpy/devsecops-lab-under-500
- Kali Linux docs: https://www.kali.org/docs/

## Wrap up

Week 1 done. Got Kali installed and hardened, SSH set up with keys, firewall configured, AppArmor profile created. System is more secure now. Ready for Week 2.

Time spent: About 6-8 hours (installation, troubleshooting, hardening)  
Cost this week: $0 (all software is free)  
Total so far: $445

Next: Week 2 - Creating a Mobile Security Hub (NetHunter + Termux)

---

Note: I used AI (ChatGPT) as a research tool for this project - basically like Google but better for learning and organizing ideas. All decisions and content are mine, but AI helped me learn faster. Being transparent about using modern tools.

