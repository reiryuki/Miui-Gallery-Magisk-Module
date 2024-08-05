mount -o rw,remount /data
MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug-pfsd.log
set -x

# var
ABI=`getprop ro.product.cpu.abi`

# function
permissive() {
if [ "$SELINUX" == Enforcing ]; then
  if ! setenforce 0; then
    echo 0 > /sys/fs/selinux/enforce
  fi
fi
}
magisk_permissive() {
if [ "$SELINUX" == Enforcing ]; then
  if [ -x "`command -v magiskpolicy`" ]; then
	magiskpolicy --live "permissive *"
  else
	$MODPATH/$ABI/libmagiskpolicy.so --live "permissive *"
  fi
fi
}
sepolicy_sh() {
if [ -f $FILE ]; then
  if [ -x "`command -v magiskpolicy`" ]; then
    magiskpolicy --live --apply $FILE 2>/dev/null
  else
    $MODPATH/$ABI/libmagiskpolicy.so --live --apply $FILE 2>/dev/null
  fi
fi
}

# selinux
SELINUX=`getenforce`
chmod 0755 $MODPATH/*/libmagiskpolicy.so
#1permissive
#2magisk_permissive
#kFILE=$MODPATH/sepolicy.rule
#ksepolicy_sh
FILE=$MODPATH/sepolicy.pfsd
sepolicy_sh

# dependency
#rm -f /data/adb/modules/MiuiCore/remove
#rm -f /data/adb/modules/MiuiCore/disable

# cleaning
FILE=$MODPATH/cleaner.sh
if [ -f $FILE ]; then
  . $FILE
  mv -f $FILE $FILE.txt
fi








