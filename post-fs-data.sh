(

mount /data
mount -o rw,remount /data
MODPATH=${0%/*}

# run
FILE=$MODPATH/sepolicy.sh
if [ -f $FILE ]; then
  sh $FILE
fi

# dependency
#rm -f /data/adb/modules/MiuiCore/remove
#rm -f /data/adb/modules/MiuiCore/disable

# cleaning
FILE=$MODPATH/cleaner.sh
if [ -f $FILE ]; then
  sh $FILE
  rm -f $FILE
fi

) 2>/dev/null






