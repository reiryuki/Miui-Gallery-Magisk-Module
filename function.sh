# function
remove_cache() {
FILES=`find $MODPATH -type f -name *.apk | sed 's|.apk||g'`
APPS=`for FILE in $FILES; do basename $FILE; done`
for APP in $APPS; do
  rm -f `find /data/system/package_cache\
   /data/dalvik-cache /data/resource-cache\
   -type f -name *$APP*`
done
}
remove_sepolicy_rule() {
rm -rf /metadata/magisk/"$MODID"\
 /mnt/vendor/persist/magisk/"$MODID"\
 /persist/magisk/"$MODID"\
 /data/unencrypted/magisk/"$MODID"\
 /cache/magisk/"$MODID"\
 /cust/magisk/"$MODID"
}




