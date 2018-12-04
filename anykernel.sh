# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=flatKernel for Asus Zenfone Max Pro M1 by @xtrymind
do.devicecheck=1
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=ASUS_X00TD
device.name2=WW_X00TD
device.name3=X00TD
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin;
chown -R root:root $ramdisk/*;


## AnyKernel install
split_boot;

# begin ramdisk changes

# init.rc

# end ramdisk changes

flash_boot;

## end install

