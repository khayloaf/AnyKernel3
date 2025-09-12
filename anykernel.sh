# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=surya
'; } # end properties

# shell variables
block="/dev/block/bootdevice/by-name/boot"
is_slot_device=0
ramdisk_compression=auto

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 750 750 "$ramdisk"/*
set_perm_recursive 0 0 750 750 "$ramdisk"/init* "$ramdisk"/sbin

# Apply Image & dtbo
mv "${home}/kernels/dtbo.img" "${home}/dtbo.img";
mv "${home}/kernels/Image.gz-dtb" "${home}/Image.gz-dtb";

## AnyKernel install
dump_boot

# migrate from /overlay to /overlay.d to enable SAR Magisk
if [ -d "$ramdisk/overlay" ]; then
  rm -rf "$ramdisk/overlay"
fi

write_boot
## end install
