# Miui Gallery Magisk Module

## DISCLAIMER
- Miui apps are owned by Xiaomi™.
- The MIT license specified here is for the Magisk Module only, not for Miui apps.

## Descriptions
Gallery app by Xiaomi Inc. ported and integrated as a Magisk Module for all supported and rooted devices with Magisk

## Sources
- https://apkmirror.com com.miui.gallery by Xiaomi Inc.
- libmagiskpolicy.so: Magisk (stable) 30.7 (30700)

v3.15
- Prepare /storage/emulated/"$UID"/Android/data/com.miui.gallery/files/mounted & com.miui.gallery/cache
- Update libmagiskpolicy.so from Magisk (stable) 30.7 (30700)
- Resets module folders/files permissions at post-fs-data
- Move _uninstall.log to /data/adb/logs/
- Merge module version and versionCode

v3.14
- Fix a crash
- Change ro.product.miui.gallery to ro.gallery.manufacturer
- Fix script bug

v3.13
- Add Action button to clear app caches
- Fix architecture detection in some weird ROMs
- Fix selinux denials
- Fix bug in uninstall.sh

v3.12
- Fix conflict with modules_update while installing via recovery if Magisk installed
- Fix MagiskHide & SUList
- Fix status bar visibility in dark theme

v3.11
- Redirect /sdcard to /data/media/"$UID"
- Move miui.global & miui.code optionals to Miui Core
- Fix MagiskHide & SUList
- Fix sepolicy denials
- Fix permissions

v3.10
- Specify UID at script
- Add optional debug.log=1 for more detailed install log
- Remove ro.opengles.version detection to fix installation via Recovery if Magisk installed
- Move uninstall log to /data/media/.../..._uninstall.log

v3.9
- Fix fatal exceptions
- Fix script bug
- Fix sepolicy denials

v3.8
- Using dex version 035 fix for Android Nougat and bellow
- KernelSU support
- Magisk v26.1 support
- Save install log at /sdcard/..._recovery.log while installing via Recovery
- Save uninstall log at /data/adb/modules/..._uninstall.log
- Fix optional permissive mode
- Set blacklist/whitelist

v3.7
- Move Delete.ogg to Miui Core
- Fix resources conflict in some ROMs
- Does not change ro.product.name
- Cleaning protected storage
- Creates /sdcard/optionals.prop file if doesn't exist
- Using magiskpolicy --live --apply sepolicy.pfsd if sepolicy.sh=1
- Fix script bug
- Using sys.boot_completed=1 detection

v3.6
- Fix a fatal exception
- package_cache deletion
- Allow installation in Android 5
- Fix sepolicy denials
- Script enhancements

## Screenshots
https://t.me/androidryukimods/180

## Requirements
- NOT in Miui ROM
- Android 5 (SDK 21) and up
- Magisk or Kitsune Mask or KernelSU or Apatch installed

## Installation Guide & Download Link
- If you are using KernelSU, you need to disable Unmount Modules by Default in KernelSU app settings and install https://github.com/KernelSU-Modules-Repo/meta-overlayfs or https://github.com/KernelSU-Modules-Repo/magic_mount_rs or https://github.com/KernelSU-Modules-Repo/hybrid_mount or https://github.com/maxsteeel/nomount first depending on ROM compatibility
- Install Miui Core Magisk Module first: https://github.com/reiryuki/Miui-Core-Magisk-Module
- Install this module CN variant https://devuploads.com/jd4fobmoh827 or global variant https://devuploads.com/uma4j2aqj2nc via Magisk app or Kitsune Mask app or KernelSU app or Apatch app or Recovery if Magisk or Kitsune Mask installed
- Reboot
- If you are using KernelSU, you need to allow superuser list manually all package name listed in package.txt (and your home launcher app also) (enable show system apps) and reboot afterwards
- If you are using SUList, you need to allow list manually your home launcher app (enable show system apps) and reboot afterwards
- Go to app info of Gallery app and allow the network access to be able to download the online features

## Optionals
- https://t.me/ryukinotes/42
- Global: https://t.me/ryukinotes/35

## Troubleshootings
- https://t.me/ryukinotes/19
- Global: https://t.me/ryukinotes/34

## Support & Bug Report
- https://t.me/ryukinotes/54
- If you don't do above, issues will be closed immediately

## Credits and Contributors
- https://t.me/androidryukimodsdiscussions
- https://t.me/androidappsportdevelopment
- ANXCamera VIP Edition Team

## Sponsors
https://t.me/ryukinotes/25


