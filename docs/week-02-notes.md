# Week 2 - NetHunter Installation Notes

## Current Status
- Device: OnePlus 7 Pro (GM1913)
- Android: 10 (Oxygen OS 10.0.10.GM21BA)
- Build: GM1913_11_H.40
- TWRP: Installed
- Magisk: 30.6 (30600) installed
- Root: Working

## Decision Made
- **Upgrading to Android 11 first** (then install NetHunter Android 11 image)
- Reason: Official NetHunter images only available for Android 11

## Installation Steps

### Step 1: Verify Android 10 Stock ROM
- [ ] Check current Android version
- [ ] Verify OxygenOS version matches requirements

### Step 2: TWRP and Magisk (Already Done)
- [x] TWRP installed
- [x] Magisk installed

### Step 3: Disable Force Encryption
- [ ] Boot into TWRP recovery
- [ ] Format /data partition
- [ ] Reboot into recovery again
- [ ] Install Magisk again
- [ ] Install Disable_Dm-Verity_ForceEncrypt zip
- [ ] Reboot to system

### Step 3.5: Upgrade to Android 11 (NEW - Added)
- [x] Download Android 11 OxygenOS ROM for OnePlus 7 Pro (GM1913) - Using Settings > System Updates (easier method!)
- [x] ROM Version: OxygenOS 11.0.9.1.GM21BA (Android 11) - DOWNLOADED, waiting to install
- [x] Backup current data (will be wiped) - IMPORTANT!
- [x] Let Oxygen Updater install Android 11 (will unroot - this is normal) - INSTALLING NOW, phone rebooting
- [x] After upgrade completes, verify Android 11 is installed - CONFIRMED: Android 11 installed!
- [x] Verify bootloader still unlocked - CONFIRMED: unlocked: yes
- [x] Download TWRP for Android 11 (OnePlus 7 Pro) - Downloaded: twrp-3.6.2_11-0-guacamole.img
- [ ] Flash TWRP via fastboot
- [ ] Boot into TWRP and install TWRP permanently
- [ ] Reinstall Magisk after upgrade
- [ ] Verify root access is working again

### Step 4: Download NetHunter Image (Updated for Android 11)
- [ ] Download Android 11 NetHunter image: OnePlus 7 / 7 Pro (OxygenOS 11)
- [ ] Download kernel separately if needed (check official guide)
- [ ] Verify SHA256 checksums

### Step 5: Install NetHunter
- [ ] Boot into TWRP recovery
- [ ] Install NetHunter zip
- [ ] Install kernel zip
- [ ] Install Magisk again
- [ ] Install disable-force-encrypter again
- [ ] Reboot
- [ ] Run NetHunter app and wait for setup
- [ ] Update NetHunter app from store

### Step 6: Disable OnePlus Update Service
- [ ] Open Android terminal as root
- [ ] Run: `su -c pm disable com.oneplus.opbackup`

## Files Needed
- [x] Disable_Dm-Verity_ForceEncrypt zip - Downloaded to downloads/ folder
- [ ] NetHunter Android 10 image for OnePlus 7 - Need to find in older releases (2024.x)
- [ ] NetHunter kernel (separate download) - Usually included or linked in NetHunter download page

## Tools Found
- OP7 Tool (All-in-One): https://xdaforums.com/t/tool-op7-tool-all-in-one-drivers-unlock-twrp-factory-image-stock-recovery.3930861/
- This tool may help with downloading factory images and upgrading

## Challenges Encountered
- Difficulty finding Android 11 OxygenOS ROM download link
- Official OnePlus site may not have direct downloads for older devices
- Need to find alternative source or method
- Oxygen Updater detected root - will unroot during upgrade (expected behavior)
- TWRP boot failed: "Failed to load/authenticate boot image: Load Error" - trying installer zip method instead
- Stock recovery doesn't have ADB sideload option - trying different approach: install Magisk first, then TWRP
- Recovery partition doesn't exist on Android 11 (recovery_a, recovery_b both failed) - OnePlus 7 Pro Android 11 might have recovery integrated into boot
- New approach: Install Magisk APK, patch boot image, flash patched boot to get root, then use root to install TWRP
- Downloaded OTA zip (11.0.9.1) using aria2
- Extracted payload.bin from OTA zip
- Extracted boot.img from payload.bin using payload_dumper.py
- Transferred boot.img to phone
- Patched boot.img with Magisk (created magisk_patched-30600_xGno1.img)
- Pulling patched boot image back to computer
- Flashed patched boot image via fastboot (boot_b partition)
- Phone rebooting to system - should have root now
- Root confirmed: Magisk installed, Ramdisk: Yes, Zygisk: No
- TWRP installer zip transferred to phone
- Ready to install TWRP using root methods
- TWRP boot via fastboot still failed (phone stuck in fastboot) - need alternative method
- Root confirmed working (uid=0)
- Checked partitions: No recovery partition exists on Android 11 (recovery integrated into boot)
- Cannot install TWRP to separate recovery partition - need alternative approach
- fastboot boot TWRP still failing: "Failed to load/authenticate boot image: Load Error"
- Installed Flashify app - using root app method to install TWRP
- TWRP image transferred to phone - ready to flash via Flashify
- Flashed TWRP using Magisk (alternative to Flashify)
- Rebooting to recovery to verify TWRP installation
- TWRP installation failed - phone booted into stock recovery instead
- Need to try different installation method (Flashify or TWRP installer zip)
- Temporary boot TWRP via fastboot succeeded! TWRP menu is showing
- Now installing TWRP permanently using TWRP installer zip
- Data partition formatted successfully via ADB (twrp format /data)
- Phone did factory reset (expected after formatting data)
- Need to set up phone again and enable USB debugging
- Then boot back into TWRP to flash Disable_Dm-Verity_ForceEncrypt zip and reinstall Magisk
- Disable_Dm-Verity_ForceEncrypt zip installation failed - file was corrupted (only 8.5KB)
- Trying to download proper version, or may skip since /data was already formatted
- Disable zip still failing - skipping for now (encryption likely already disabled after formatting /data)
- Proceeding with NetHunter installation (Step 4 from official guide)
- NetHunter zip transferred to phone successfully (2.4 GB)
- NetHunter installation failed with Error 1 in TWRP
- Need to troubleshoot: may need Magisk reinstalled first, or kernel separately
- **FOUND THE ISSUE**: NetHunter installer says "Dynamic Device Detected - cannot be installed via recovery. Please flash via Magisk as module"
- NetHunter must be installed as Magisk module, not via TWRP!
- Need to reinstall Magisk first, then install NetHunter as Magisk module
- Boot image patched with Magisk (magisk_patched-30600_0q17R.img)
- Flashing patched boot image to restore root
- **IMPORTANT**: System update received - must cancel it! Update will unroot device and break NetHunter
- Root restored successfully (uid=0)
- OnePlus update service disabled (com.oneplus.opbackup)
- Ready to install NetHunter as Magisk module
- NetHunter installation started via Magisk module installer
- Kali chroot installation in progress (~25 minutes)
- Installation must complete before rebooting
- **Clarification**: NetHunter does NOT replace Android - it runs on top of Android as a security overlay/environment
- NetHunter installation complete! (~25 minutes for Kali chroot)
- Ready to reboot and verify NetHunter is working
- **SUCCESS!** NetHunter installed and working!
- NetHunter app version 2025.4 (2025110300) confirmed
- All NetHunter apps visible: NetHunter, NetHunter KeX, NetHunter Store, NetHunter Terminal
- Main NetHunter interface operational
- Week 2 installation complete!

## Lessons Learned
- **EASIER METHOD FOUND**: Could have just updated via Settings > System Updates on phone directly (much simpler!)
- Sometimes the simplest solution is right there in the phone settings
- Should have checked phone settings first before searching for downloads

## Alternative Solutions Considered
- Use Oxygen Updater app on phone
- Use custom ROM (LineageOS 18.1) instead of stock OxygenOS
- Direct download from XDA or archive sites

## Solutions Found
- [To be filled as we progress]

## Time Spent
- [To be filled]

## Cost
- $0 (all software is free)

