# Week 2: Creating a Mobile Security Hub (NetHunter + Termux)

Date: 27/12/2025

Week 2 is done. Got NetHunter installed on the OnePlus 7 Pro. This was way more involved than I expected - took way longer than Week 1, but learned a lot about Android rooting and custom recovery.

## What I did this week

### Installing NetHunter

The goal was to set up Kali NetHunter on an Android phone. NetHunter is basically Kali Linux tools running on Android - gives you penetration testing capabilities on a phone. Pretty cool for on-the-go security work.

Had a OnePlus 7 Pro that was already on Android 10. Bootloader was already unlocked from previous attempts. The official NetHunter guide is for Android 10, but NetHunter images are available for Android 11, so decided to upgrade first.

### Upgrading to Android 11

First challenge - finding the right Android 11 ROM. Looked at Oxygen Updater app, XDA forums, official OnePlus site. Turns out the easiest way was just using the phone's built-in System Updates. Should have checked that first instead of searching everywhere.

Upgraded to OxygenOS 11.0.9.1 (Android 11). The upgrade wiped root access, which is normal. Bootloader stayed unlocked, which is what we needed.

### Getting Root Back

After the upgrade, needed to get root access again. Downloaded the full OTA zip, extracted the boot image from it using a Python script called payload_dumper, transferred it to the phone, patched it with Magisk app, then flashed the patched boot image back via fastboot. This worked - root was back.

![Phone in fastboot mode](assets/images/week%202/phone%20in%20fastboot%20mode.jpeg)

![PowerShell showing device connected](assets/images/week%202/powershell%20showing%20device%20connected.png)

### Installing TWRP

Tried to install TWRP custom recovery. This is where things got complicated.

First tried flashing recovery directly - failed because Android 11 doesn't have a separate recovery partition. Recovery is integrated into the boot partition on newer Android versions.

Tried temporary boot of TWRP - kept failing with errors. Tried different TWRP versions, same issue. Tried using Flashify app (root app that can flash recovery) - didn't work either.

Finally got it working with temporary boot on what felt like the 10th attempt. TWRP booted successfully. Couldn't install it permanently, but temporary boot works fine for what we need.

![TWRP booted successfully](assets/images/week%202/WhatsApp%20Image%202025-12-27%20at%2010.30.26.jpeg)

### Disabling Force Encryption

According to the official guide, need to disable force encryption. Booted into TWRP, formatted the /data partition using ADB commands. This wiped everything (factory reset) - expected behavior. Tried to flash a disable encryption zip, but it kept failing because the file was corrupted. Since we formatted /data, encryption is likely already disabled anyway, so skipped it.

### Installing NetHunter

This is where it got interesting. Tried to flash NetHunter zip via TWRP - got Error 1. Checked the TWRP logs and found a message saying the device is "dynamic" and NetHunter can't be installed via recovery - needs to be installed via Magisk as a module instead.

![NetHunter installation error in TWRP](assets/images/week%202/WhatsApp%20Image%202025-12-27%20at%2011.00.00.jpeg)

So the process became: reinstall Magisk (get root back after factory reset), then install NetHunter as a Magisk module instead of via TWRP.

Downloaded NetHunter 2025.4 image (2.4 GB). Transferred it to the phone. In Magisk app, went to Modules tab, selected "Install from storage", chose the NetHunter zip. Magisk started installing it as a module.

The Kali chroot installation took about 25 minutes - it's extracting and setting up the full Kali Linux environment. Just had to wait and let it finish.

![NetHunter installation in progress](assets/images/week%202/WhatsApp%20Image%202025-12-27%20at%2011.12.36.jpeg)

After installation, rebooted the phone. NetHunter app appeared in the app drawer. Opened it - everything working!

![NetHunter installed and working](assets/images/week%202/WhatsApp%20Image%202025-12-27%20at%2011.54.35.jpeg)

### Disabling OnePlus Updates

Important step - disabled OnePlus update service to prevent automatic updates that would break root and NetHunter. Used ADB command: `su -c pm disable com.oneplus.opbackup`. Also got a system update notification during setup - had to cancel it. Updates would unroot the device and break NetHunter.

## Challenges

**Finding the right ROM:** Spent too much time searching for Android 11 ROM downloads when the easiest method was just using System Updates in phone settings. Lesson learned - check the simplest solution first.

**TWRP installation:** Android 11 doesn't have a separate recovery partition, so permanent TWRP installation is tricky. Temporary boot works fine though. Tried multiple methods - fastboot flash, Flashify app, Magisk - none worked for permanent installation. Eventually got temporary boot working which is enough.

![Windows not recognizing device](assets/images/week%202/windows%20not%20recognizing%20device.png)

**NetHunter installation method:** The official guide says to install via TWRP, but newer devices require Magisk module installation instead. The error message in TWRP logs was helpful - it told us exactly what to do. This was the breakthrough moment.

**File downloads:** Several downloads got corrupted (TWRP installer zip, Disable_Dm-Verity_ForceEncrypt zip). Had to re-download multiple times or find alternative sources. Some files were only a few KB when they should have been much larger - clearly corrupted.

**Troubleshooting time:** This took way longer than expected. Between troubleshooting TWRP (tried fastboot flash, temporary boot multiple times, Flashify app, Magisk), figuring out the Magisk module method, dealing with corrupted downloads, and waiting for installations, probably spent 12-15 hours total. Way more than Week 1.

**System updates:** Got a system update notification during setup. Had to make sure not to install it, then disabled update service to prevent future issues.

**Factory reset:** Formatting /data partition caused factory reset (expected, but inconvenient). Had to re-enable USB debugging, reinstall Magisk, go through setup again. Just part of the process but added time.

**TWRP keyboard issues:** TWRP Format Data screen required typing "yes" but keyboard wasn't working. Used ADB command instead which worked fine. ADB is often more reliable than TWRP's touch interface.

## What I learned

Android rooting is more complex than I thought. Each Android version and device model has different requirements. What works for one device might not work for another. Android 11 has different partition structure than Android 10 - no separate recovery partition.

Temporary boot TWRP works fine - don't necessarily need permanent installation. Good to know for future reference.

Magisk module installation is the modern way for some devices. The official guide is for Android 10, but Android 11+ devices often need the Magisk module method instead. Always check error logs when something fails - they often tell you exactly what to do.

NetHunter doesn't replace Android - it runs on top of it. You still have all your Android apps and functions, plus NetHunter security tools. Good to clarify that.

File downloads can get corrupted - verify file sizes. If something seems too small, it's probably corrupted.

ADB commands are often more reliable than GUI interfaces in recovery. When TWRP's keyboard didn't work, ADB saved the day.

The key was persistence and checking error messages. The TWRP log that told us to use Magisk module installation was the breakthrough moment. Sometimes you just have to keep trying different approaches until something works.

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
