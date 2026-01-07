# Week 4 Testing Notes - Kali Linux

**Copyright (C) 2026  G A Istrati**

This work is licensed under the GNU General Public License v3.0 (GPL-3.0).
See LICENSE file for full license text.

**Disclaimer:** This project is for educational purposes only. Users are responsible for ensuring their use complies with all applicable laws.

## Testing the Log Collector on Kali Linux

### Expected Behavior

When you run the log collector on Kali Linux, you should see:

```
=== Log Collector Starting ===

--- .env Test ---
Message from .env: Hello from .env file!

--- System Information ---
Hostname: kali-lab (or your Kali hostname)
Platform: Linux 5.x.x (kernel version)
Architecture: x86_64 (or your architecture)
Processor: (processor info)
Timestamp: 2026-01-06T12:30:00.000000

--- Memory Information ---
Total Memory: 8.00 GB (or your RAM)
Available: X.XX GB
Used: X.XX GB (XX.X%)
```

### Steps to Test on Kali

1. **Copy files to Kali:**
   ```bash
   # From your Windows machine, copy the project to Kali
   # Or clone from git if you've pushed it
   ```

2. **Install dependencies:**
   ```bash
   cd devsecops-lab-under-500/infra
   pip3 install -r requirements.txt
   # May need: pip3 install psutil
   ```

3. **Ensure .env file exists:**
   ```bash
   # Copy .env file to Kali (manually, it's not in git)
   cp ../security/secrets/env.example ../security/secrets/.env
   # Edit .env and add your TEST_MESSAGE
   ```

4. **Run the script:**
   ```bash
   python3 log-collector.py
   ```

5. **Expected differences from Windows:**
   - Platform will show "Linux" instead of "Windows"
   - Hostname will be your Kali hostname
   - Processor info will be different
   - Memory values will match your Kali system

### Testing Pre-commit Hook on Kali

The pre-commit hook should work the same way:

1. **Test blocking a secret:**
   - Create a test file containing a secret pattern (like variables that match API_KEY, PASSWORD, TOKEN patterns)
   - Add it to git: `git add test.txt`
   - Try to commit: `git commit -m "test"`
   - The pre-commit hook should detect the secret and block the commit
   - You'll see an error message explaining what was found

2. **Test normal commit:**
   ```bash
   git add infra/log-collector.py
   git commit -m "Week 4: Add log collector"  # Should work
   ```

### Notes

- Make sure you have the `.env` file on Kali (it's not in git)
- The hook should work the same on Linux as on Windows
- GPG is pre-installed on Kali, so you can learn encryption there

