# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=flatKernel for Asus Zenfone Max Pro M1 by @xtrymind
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=X00T
device.name2=X00TD
supported.versions=9
'; } # end properties

# shell variables
block=/dev/block/platform/soc/c0c4000.sdhci/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.rc

# Optimize F2FS extension list (@arter97)
find /sys/fs/f2fs -name extension_list | while read list; do
  if grep -q odex "$list"; then
    echo "Extensions list up-to-date: $list"
    continue
  fi

  echo "Updating extension list: $list"

  echo "Clearing extension list"

  HOT=$(cat $list | grep -n 'hot file extens' | cut -d : -f 1)
  COLD=$(($(cat $list | wc -l) - $HOT))

  COLDLIST=$(head -n$(($HOT - 1)) $list | grep -v ':')
  HOTLIST=$(tail -n$COLD $list)

  echo $COLDLIST | tr ' ' '\n' | while read cold; do
    if [ ! -z $cold ]; then
      echo "[c]!$cold" > $list
    fi
  done

  echo $HOTLIST | tr ' ' '\n' | while read hot; do
    if [ ! -z $hot ]; then
      echo "[h]!$hot" > $list
    fi
  done

  echo "Writing new extension list"

  cat /tmp/anykernel/f2fs-cold.list | grep -v '#' | while read cold; do
    if [ ! -z $cold ]; then
      echo "[c]$cold" > $list
    fi
  done

  cat /tmp/anykernel/f2fs-hot.list | while read hot; do
    if [ ! -z $hot ]; then
      echo "[h]$hot" > $list
    fi
  done
done

# end ramdisk changes

write_boot;

## end install

