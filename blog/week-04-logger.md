# Week 4: Building the Agent (Python/Bash Log Collector)

**Copyright (C) 2026  G A Istrati**

This work is licensed under the GNU General Public License v3.0 (GPL-3.0).
See LICENSE file for full license text.

**Disclaimer:** This project is for educational purposes only. Users are responsible for ensuring their use complies with all applicable laws.

---

Date: 01/06/2026

Week 4 is done. Built a log collector script and learned about secure secret handling. This week was all about writing code that collects system information while keeping secrets safe.

## What I did this week

### The Goal

Week 4's goal was to build a log collector agent that:
1. Collects system logs and metrics
2. Handles secrets securely (no hardcoded passwords)
3. Can run on both my Kali Linux laptop and Android phone
4. Has security checks to prevent committing secrets

### Building the Log Collector

Started with a simple Python script that prints basic system information. Learned step by step:

**Step 1: Basic System Info**
- Used Python's `platform` module to get hostname, OS, architecture
- Added timestamp using `datetime`
- Simple script that just printed what system it was running on

**Step 2: Adding More Information**
- Added memory collection using `psutil` library
- Shows total memory, available, used, and percentage
- Works on both Windows (for testing) and Linux (for production)

**Step 3: Learning About .env Files**

This was the important security lesson. Learned why you should never hardcode secrets:

**The Problem:**
```python
# ❌ BAD - Never do this!
api_url = "https://my-server.com"
password = "secret123"
```

If you commit this to git, your secrets are in git history forever. Even if you delete them later, they're still there.

**The Solution: .env Files**
- Store secrets in a separate `.env` file
- The `.env` file is NOT committed to git (it's in `.gitignore`)
- Your script reads from `.env` at runtime
- Different people can have different `.env` files

**How it works:**
1. Created `security/secrets/.env` from the template
2. Added a test value: `TEST_MESSAGE=Hello from .env file!`
3. Installed `python-dotenv` library
4. Modified script to load `.env` file using `load_dotenv()`
5. Read values using `os.getenv('TEST_MESSAGE')`

When I ran the script, it successfully read and printed the message from `.env`. Felt good to see it working!

### Creating the Pre-commit Hook

This was the coolest part. A pre-commit hook is a script that runs automatically before you commit code to git.

**Why we need it:**
- Prevents accidentally committing secrets
- Catches mistakes before they reach git
- Once secrets are in git, they're hard to remove completely

**How it works:**
1. Created `security/pre-commit/gitleaks-hook.sh`
2. Script checks all files you're about to commit
3. Looks for secret patterns like API_KEY, PASSWORD, TOKEN, etc. (with equals signs)
4. If it finds secrets, it blocks the commit and shows an error
5. If no secrets found, it allows the commit

**Testing the hook:**
- Created a test file containing a secret pattern (API_KEY with a value)
- Tried to commit it → Hook blocked it! ✅
- Removed the secret → Commit worked! ✅

The hook even caught itself at first (because it contains the patterns it's looking for), so I had to update it to skip checking itself. Good learning moment - the hook was working so well it was even protecting itself!

### Creating requirements.txt

Created `infra/requirements.txt` to list Python dependencies:
```
python-dotenv==1.0.0
```

This way, anyone can install the dependencies with `pip install -r requirements.txt`.

## What I learned

### Security Best Practices

1. **Never hardcode secrets** - Always use `.env` files or environment variables
2. **Pre-commit hooks are powerful** - They catch mistakes before they become problems
3. **Defense in depth** - Multiple layers of security (`.gitignore` + pre-commit hook)

### Python Skills

1. **Environment variables** - Using `python-dotenv` to load configuration
2. **System information** - Using `platform` and `psutil` modules
3. **File paths** - Using `pathlib.Path` for cross-platform file paths

### Git Hooks

1. **Pre-commit hooks** - Scripts that run before commits
2. **How to install** - Copy script to `.git/hooks/pre-commit`
3. **How to test** - Create test files with secrets and try to commit

## Challenges

### Pre-commit Hook Catching Itself

The hook script contains the patterns it's looking for (like API_KEY patterns in the patterns array). When I tried to commit the hook itself, it blocked the commit!

**Solution:** Updated the hook to skip checking itself:
```bash
# Skip checking the hook script itself
if [[ "$FILE" == *"gitleaks-hook.sh"* ]] || [[ "$FILE" == *"pre-commit"* ]]; then
    continue
fi
```

Good lesson - sometimes security tools need to exclude themselves.

### Testing Notes File Triggering Hook

Created a testing notes file with examples containing secret patterns in the documentation. The hook detected them even though they were just examples!

**Solution:** Removed the actual pattern from the documentation, kept it as description only.

### Windows vs Linux Paths

The script needs to work on both Windows (for development) and Linux (for production). Used `pathlib.Path` which handles both automatically.

## Files Created

- `infra/log-collector.py` - Main log collector script
- `infra/requirements.txt` - Python dependencies
- `security/pre-commit/gitleaks-hook.sh` - Pre-commit hook script
- `security/secrets/.env` - Environment variables (not in git)
- `docs/week-04-testing-notes.md` - Testing guide for Kali Linux

## Next Steps

Week 5 will be about securing the telemetry - encrypting the connection between agents and the cloud VM. But first, I need to:

1. Test the script on Kali Linux (GPG is pre-installed there, so I can learn encryption)
2. Test on the OnePlus 7 Pro if possible
3. Maybe add more log collection features

## Time Spent

About 6-8 hours total:
- Learning about .env files and security: 2 hours
- Writing the log collector script: 2 hours
- Creating and testing pre-commit hook: 2 hours
- Testing and troubleshooting: 2 hours

## Key Takeaways

1. **Security from the start** - Building security in from the beginning is easier than adding it later
2. **Automation is powerful** - Pre-commit hooks catch mistakes automatically
3. **Learning step by step** - Breaking things into small steps made it manageable
4. **Testing is important** - Testing the hook with real examples helped me understand it better

Week 4 complete! The log collector is working, secrets are handled securely, and we have automated checks to prevent mistakes. Ready for Week 5!

---

**Note:** I used AI (ChatGPT) as a research tool for this project - basically like Google but better for learning and organizing ideas. All decisions and content are mine, but AI helped me learn faster. Being transparent about using modern tools.

