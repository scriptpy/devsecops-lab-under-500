# Week 2: Creating a Mobile Security Hub (NetHunter + Termux)

Date: 27/12/2025

Week 2 is done. Got NetHunter installed on the OnePlus 7 Pro. This was way more involved than I expected - took way longer than Week 1, but learned a lot about Android rooting and custom recovery.

## What I did this week

### The Goal

Set up Kali NetHunter on an Android phone to create a mobile security testing platform. NetHunter is basically Kali Linux tools running on Android - gives you penetration testing capabilities on a phone. Pretty cool for on-the-go security work.

### Starting Point

Had a OnePlus 7 Pro (GM1913) that was already on Android 10. Bootloader was already unlocked from previous attempts. The official NetHunter guide is for Android 10, but NetHunter images are available for Android 11, so decided to upgrade first.

### Upgrading to Android 11

First challenge - finding the right Android 11 ROM. Looked at Oxygen Updater app, XDA forums, official OnePlus site. Turns out the easiest way was just using the phone's built-in System Updates. Should have checked that first instead of searching everywhere.

Upgraded to OxygenOS 11.0.9.1 (Android 11). The upgrade wiped root access, which is normal. Bootloader stayed unlocked, which is what we needed.

### Getting Root Back

After the upgrade, needed to get root access again. Process:

1. Downloaded the full OTA zip for Android 11
2. Extracted `payload.bin` from the zip
3. Used `payload_dumper.py` to extract `boot.img` from the payload
4. Transferred `boot.img` to the phone
5. Patched it with Magisk app (creates a patched boot image)
6. Pulled the patched image back to PC
7. Flashed it via fastboot: `fastboot flash boot_b magisk_patched_boot.img`
8. Rebooted and verified root with `su -c id` (shows uid=0)

This worked. Root was back.

### Installing TWRP

Tried to install TWRP custom recovery. This is where things got complicated.

First tried `fastboot flash recovery` - failed because Android 11 doesn't have a separate recovery partition (recovery is integrated into boot on newer Android versions).

Tried `fastboot boot twrp.img` (temporary boot) - kept failing with "Failed to load/authenticate boot image: Load Error". Tried different TWRP versions, same issue.

Tried using Flashify app (root app that can flash recovery) - didn't work either.

Finally got it working with temporary boot: `fastboot boot twrp-3.6.2_11-0-guacamole.img` - this time it worked! TWRP booted successfully. Couldn't install it permanently, but temporary boot works fine for what we need.

### Disabling Force Encryption

According to the official guide, need to disable force encryption. Process:

1. Booted into TWRP (temporary boot)
2. Formatted /data partition using ADB: `adb shell "twrp format /data"`
3. This wiped everything (factory reset) - expected behavior
4. Tried to flash Disable_Dm-Verity_ForceEncrypt zip, but it kept failing (file was corrupted)
5. Since we formatted /data, encryption is likely already disabled, so skipped the zip

### Installing NetHunter

This is where it got interesting. Tried to flash NetHunter zip via TWRP - got Error 1. Checked the TWRP logs and found this message:

```
********** Dynamic Device Detected **********

This Kali NetHunter package cannot be
installed on this device via recovery.
Please flash this file via Magisk 
as module and ensure you have USB DEBUGGING
enabled for using ADB
```

Ah! NetHunter detected this as a "dynamic device" and requires installation via Magisk module, not TWRP. This is a newer requirement for some Android 11+ devices.

So the process became:
1. Reinstall Magisk (get root back after factory reset)
2. Install NetHunter as a Magisk module instead of via TWRP

Downloaded NetHunter 2025.4 image (2.4 GB) - `kali-nethunter-2025.4-oneplus7-v2-oos-eleven-full.zip`. Transferred it to the phone.

In Magisk app:
1. Opened Magisk
2. Went to Modules tab
3. Selected "Install from storage"
4. Chose the NetHunter zip
5. Magisk started installing it as a module

The Kali chroot installation took about 25 minutes - it's extracting and setting up the full Kali Linux environment. Just had to wait and let it finish.

After installation, rebooted the phone. NetHunter app appeared in the app drawer. Opened it - everything working!

### Disabling OnePlus Updates

Important step - disabled OnePlus update service to prevent automatic updates that would break root and NetHunter:

```bash
su -c pm disable com.oneplus.opbackup
```

Also got a system update notification during setup - had to cancel it. Updates would unroot the device and break NetHunter.

### Final Result

NetHunter 2025.4 is now installed and working on the OnePlus 7 Pro. Can see all the NetHunter apps:
- NetHunter (main app)
- NetHunter KeX (desktop experience)
- NetHunter Store
- NetHunter Terminal

Main NetHunter interface shows all the features available - Kali Chroot Manager, Kali Services, MAC Changer, USB Arsenal, HID Attacks, and more.

## Challenges

**Finding the right ROM:** Spent too much time searching for Android 11 ROM downloads when the easiest method was just using System Updates in phone settings. Lesson learned - check the simplest solution first.

**TWRP installation:** Android 11 doesn't have a separate recovery partition, so permanent TWRP installation is tricky. Temporary boot works fine though.

**NetHunter installation method:** The official guide says to install via TWRP, but newer devices require Magisk module installation instead. The error message in TWRP logs was helpful - it told us exactly what to do.

**File downloads:** Several downloads got corrupted (TWRP installer zip, Disable_Dm-Verity_ForceEncrypt zip). Had to re-download multiple times or find alternative sources.

**Time:** This took way longer than expected. Between troubleshooting TWRP, figuring out the Magisk module method, and waiting for installations, probably spent 12-15 hours total. Way more than Week 1.

**System updates:** Got a system update notification during setup. Had to make sure not to install it, then disabled update service to prevent future issues.

## Troubleshooting and Dead Ends

This week had a lot of trial and error. Here's what didn't work and why, in case it helps someone else:

### TWRP Installation Attempts

**Dead End #1: `fastboot flash recovery`**
- Tried: `fastboot flash recovery twrp-3.6.2_11-0-guacamole.img`
- Error: `FAILED (remote: '(recovery_b) No such partition')`
- Why it failed: Android 11 doesn't have a separate recovery partition. Recovery is integrated into the boot partition on newer Android versions.
- Lesson: Check partition structure first before trying to flash.

**Dead End #2: `fastboot boot` (first attempts)**
- Tried: `fastboot boot twrp-3.6.2_11-0-guacamole.img` multiple times
- Error: `FAILED (remote: 'Failed to load/authenticate boot image: Load Error')`
- Why it failed: Not sure exactly - might have been wrong TWRP version, or device needed to be in a specific state. Eventually worked on later attempt.
- Lesson: Sometimes things work on retry. Also, make sure you're using the correct TWRP version for your exact Android version.

**Dead End #3: Flashify app**
- Tried: Using Flashify (root app) to flash TWRP image
- Result: App installed, but TWRP didn't actually install - phone still booted into stock recovery
- Why it failed: Not entirely sure - might be Android 11 compatibility issue, or the way recovery is integrated into boot
- Lesson: Root apps aren't always reliable for system-level changes.

**Dead End #4: Magisk to flash TWRP**
- Tried: Using Magisk's "Select and Patch a File" to flash TWRP
- Result: Phone booted into stock recovery, not TWRP
- Why it failed: Magisk is for patching boot images for root, not for installing recovery
- Lesson: Use the right tool for the job. Magisk is for root, not recovery.

**What worked:** Temporary boot via `fastboot boot` eventually worked. Couldn't install permanently, but temporary boot is fine for our needs.

### File Download Issues

**Dead End #5: Corrupted TWRP installer zip**
- Problem: Downloaded `twrp-installer-3.6.2_11-0-guacamole.zip` multiple times
- Issue: File was only 7-8 KB instead of expected ~20-30 MB
- Error: `unzip: couldn't open: Invalid file` or `End of Central Directory record could not be found`
- Why it failed: Downloads kept getting corrupted, possibly network issues or server problems
- Solution: Eventually gave up on permanent TWRP installation, used temporary boot instead
- Lesson: Verify file sizes after download. If something seems too small, it's probably corrupted.

**Dead End #6: Corrupted Disable_Dm-Verity_ForceEncrypt zip**
- Problem: Downloaded multiple times, file was only 8.5 KB
- Error: Installation failed in TWRP
- Why it failed: File was corrupted or incomplete
- Solution: Skipped it since formatting /data likely already disabled encryption
- Lesson: Some files are legitimately small (script-based zips), but verify they're not corrupted. Check file hashes if available.

### NetHunter Installation Issues

**Dead End #7: NetHunter via TWRP**
- Tried: Flashing NetHunter zip via TWRP (as official guide suggests)
- Error: `Error 1` in TWRP
- TWRP log showed:
  ```
  ********** Dynamic Device Detected **********
  This Kali NetHunter package cannot be
  installed on this device via recovery.
  Please flash this file via Magisk 
  as module and ensure you have USB DEBUGGING
  enabled for using ADB
  ```
- Why it failed: Android 11+ devices with "dynamic" partition structure require Magisk module installation, not TWRP
- Solution: Installed as Magisk module instead
- Lesson: Always check error logs - they often tell you exactly what to do. The error message was actually helpful.

### Other Issues

**Issue #8: System update notification**
- Problem: Got system update notification during setup
- Risk: Installing would unroot device and break NetHunter
- Solution: Cancelled update, then disabled OnePlus update service
- Lesson: Disable updates early to prevent accidental installation

**Issue #9: Factory reset after formatting /data**
- Problem: Formatting /data partition caused factory reset (expected, but inconvenient)
- Impact: Had to re-enable USB debugging, reinstall Magisk, etc.
- Solution: Just part of the process - had to go through it
- Lesson: Formatting /data will wipe everything. Make sure you're ready for that.

**Issue #10: Couldn't type "yes" in TWRP**
- Problem: TWRP Format Data screen required typing "yes" but keyboard wasn't working
- Solution: Used ADB command instead: `adb shell "twrp format /data"`
- Lesson: ADB is often more reliable than TWRP's touch interface for commands.

### What We Learned

Most of these dead ends taught us something:
- Android 11 has different partition structure than Android 10
- Temporary boot TWRP is often sufficient - don't need permanent installation
- Always check error logs - they're usually helpful
- File downloads can get corrupted - verify file sizes
- Official guides may be for older Android versions - newer versions might need different methods
- ADB commands are often more reliable than GUI interfaces in recovery

The key was persistence and checking error messages. The TWRP log that told us to use Magisk module installation was the breakthrough moment.

## What I learned

Android rooting is more complex than I thought. Each Android version and device model has different requirements. What works for one device might not work for another.

Temporary boot TWRP works fine - don't necessarily need permanent installation. Good to know for future reference.

Magisk module installation is the modern way for some devices. The official guide is for Android 10, but Android 11+ devices often need the Magisk module method instead.

Always check TWRP logs when something fails - the error messages are actually helpful and tell you what to do.

NetHunter doesn't replace Android - it runs on top of it. You still have all your Android apps and functions, plus NetHunter security tools. Good to clarify that.

## NetHunter Limitations

Compared to full Kali Linux on a laptop:
- Slower performance (mobile CPU vs desktop)
- Some tools may not work (hardware/kernel limitations)
- Battery drains faster during intensive operations
- Limited by phone storage capacity

But it's still powerful and useful for:
- Mobile security testing
- Network reconnaissance on-the-go
- Learning penetration testing
- Complementing the Kali lab laptop

For this project, it's perfect - adds a mobile component to the lab setup.

## Next week

Week 3 is Infrastructure as Code with Terraform. Need to set up a cloud VM and write Terraform configs to provision it. Should be simpler than this week - no rooting or custom recovery needed.

## Links

- Project repo: https://github.com/scriptpy/devsecops-lab-under-500
- Kali NetHunter docs: https://www.kali.org/docs/nethunter/
- Official OnePlus 7 NetHunter guide: https://www.kali.org/docs/nethunter/installing-nethunter-on-the-oneplus-7/

## Wrap up

Week 2 done. Got NetHunter installed on the OnePlus 7 Pro. Took way longer than expected, but learned a lot about Android rooting, TWRP, Magisk, and NetHunter installation. The phone is now a mobile security testing platform. Ready for Week 3.

Time spent: About 12-15 hours (upgrade, rooting, TWRP troubleshooting, NetHunter installation)  
Cost this week: $0 (all software is free)  
Total so far: $445

Next: Week 3 - IaC Foundation: Terraform on Cheap Cloud VM

---

Note: I used AI (ChatGPT) as a research tool for this project - basically like Google but better for learning and organizing ideas. All decisions and content are mine, but AI helped me learn faster. Being transparent about using modern tools.

