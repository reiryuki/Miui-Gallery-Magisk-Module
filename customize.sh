ui_print " "

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
ui_print " MagiskVersion=$MAGISK_VER"
ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
ui_print " "

# bit
if [ "$IS64BIT" != true ]; then
  ui_print "- 32 bit"
  rm -rf `find $MODPATH/system -type d -name *64`
else
  ui_print "- 64 bit"
fi
ui_print " "

# sepolicy.rule
if [ "$BOOTMODE" != true ]; then
  mount -o rw -t auto /dev/block/bootdevice/by-name/persist /persist
  mount -o rw -t auto /dev/block/bootdevice/by-name/metadata /metadata
fi
FILE=$MODPATH/sepolicy.sh
DES=$MODPATH/sepolicy.rule
if [ -f $FILE ] && ! getprop | grep -Eq "sepolicy.sh\]: \[1"; then
  mv -f $FILE $DES
  sed -i 's/magiskpolicy --live "//g' $DES
  sed -i 's/"//g' $DES
fi

# sdk
NUM=23
if [ "$API" -lt $NUM ]; then
  ui_print "! Unsupported SDK $API."
  ui_print "  You have to upgrade your Android version"
  ui_print "  at least SDK API $NUM to use this module."
  abort
else
  ui_print "- SDK $API"
  ui_print " "
fi

# opengles
PROP=`getprop ro.opengles.version`
NUM=131072
if [ "$PROP" -lt $NUM ]; then
  ui_print "! Unsupported OpenGLES $PROP. This module is only for"
  ui_print "  OpenGLES $NUM and up."
  abort
else
  ui_print "- OpenGLES $PROP"
  ui_print " "
fi

# miuicore
if [ ! -d /data/adb/modules_update/MiuiCore ] && [ ! -d /data/adb/modules/MiuiCore ]; then
  ui_print "! Miui Core Magisk Module is not installed."
  ui_print "  Please read github installation guide!"
  abort
else
  rm -f /data/adb/modules/MiuiCore/remove
  rm -f /data/adb/modules/MiuiCore/disable
fi

# cleaning
ui_print "- Cleaning..."
APP="`ls $MODPATH/system/priv-app` `ls $MODPATH/system/app`"
PKG=com.miui.gallery
if [ "$BOOTMODE" == true ]; then
  for PKGS in $PKG; do
    RES=`pm uninstall $PKGS`
  done
fi
for APPS in $APP; do
  rm -f `find /data/dalvik-cache /data/resource-cache -type f -name *$APPS*.apk`
done
rm -f $MODPATH/LICENSE
rm -rf /metadata/magisk/$MODID
rm -rf /mnt/vendor/persist/magisk/$MODID
rm -rf /persist/magisk/$MODID
rm -rf /data/unencrypted/magisk/$MODID
rm -rf /cache/magisk/$MODID
ui_print " "

# power save
PROP=`getprop power.save`
FILE=$MODPATH/system/etc/sysconfig/*
if [ "$PROP" == 1 ]; then
  ui_print "- $MODNAME will not be allowed in power save."
  ui_print "  It may save your battery but decreasing $MODNAME performance."
  for PKGS in $PKG; do
    sed -i "s/<allow-in-power-save package=\"$PKGS\"\/>//g" $FILE
    sed -i "s/<allow-in-power-save package=\"$PKGS\" \/>//g" $FILE
  done
  ui_print " "
fi

# magisk
if [ -d /sbin/.magisk ]; then
  MAGISKTMP=/sbin/.magisk
else
  MAGISKTMP=`find /dev -mindepth 2 -maxdepth 2 -type d -name .magisk`
fi

# function
conflict() {
for NAMES in $NAME; do
  DIR=/data/adb/modules_update/$NAMES
  if [ -f $DIR/uninstall.sh ]; then
    sh $DIR/uninstall.sh
  fi
  rm -rf $DIR
  DIR=/data/adb/modules/$NAMES
  rm -f $DIR/update
  touch $DIR/remove
  FILE=/data/adb/modules/$NAMES/uninstall.sh
  if [ -f $FILE ]; then
    sh $FILE
    rm -f $FILE
  fi
  rm -rf /metadata/magisk/$NAMES
  rm -rf /mnt/vendor/persist/magisk/$NAMES
  rm -rf /persist/magisk/$NAMES
  rm -rf /data/unencrypted/magisk/$NAMES
  rm -rf /cache/magisk/$NAMES
done
}

# conflict
NAME=MIUIGallery
conflict

# function
cleanup() {
if [ -f $DIR/uninstall.sh ]; then
  sh $DIR/uninstall.sh
fi
DIR=/data/adb/modules_update/$MODID
if [ -f $DIR/uninstall.sh ]; then
  sh $DIR/uninstall.sh
fi
}

# cleanup
DIR=/data/adb/modules/$MODID
FILE=$DIR/module.prop
if getprop | grep -Eq "miui.cleanup\]: \[1"; then
  ui_print "- Cleaning-up $MODID data..."
  cleanup
  ui_print " "
elif [ -d $DIR ] && ! grep -Eq "$MODNAME" $FILE; then
  ui_print "- Different version detected"
  ui_print "  Cleaning-up $MODID data..."
  cleanup
  ui_print " "
fi

# function
permissive() {
  SELINUX=`getenforce`
  if [ "$SELINUX" == Enforcing ]; then
    setenforce 0
    SELINUX=`getenforce`
    if [ "$SELINUX" == Enforcing ]; then
      ui_print "  ! Your device can't be turned to Permissive state."
    fi
    setenforce 1
  fi
  sed -i '1i\
SELINUX=`getenforce`\
if [ "$SELINUX" == Enforcing ]; then\
  setenforce 0\
fi\' $MODPATH/post-fs-data.sh
}

# permissive
if getprop | grep -Eq "permissive.mode\]: \[1"; then
  ui_print "- Using permissive method"
  rm -f $MODPATH/sepolicy.rule
  permissive
  ui_print " "
elif getprop | grep -Eq "permissive.mode\]: \[2"; then
  ui_print "- Using both permissive and SE policy patch"
  permissive
  ui_print " "
fi

# function
extract_lib() {
  for APPS in $APP; do
    ui_print "- Extracting $APPS.apk libs..."
    FILE=`find $MODPATH/system -type f -name $APPS.apk`
    DIR=`find $MODPATH/system -type d -name $APPS`/lib/$ARCH
    mkdir -p $DIR
    rm -rf $TMPDIR/*
    unzip -d $TMPDIR -o $FILE $DES
    cp -f $TMPDIR/$DES $DIR
    ui_print " "
  done
}

# extract
PROP=`getprop ro.product.cpu.abi`
DES=lib/$PROP/*
extract_lib

# features
PROP=`getprop miui.features`
FILE=$MODPATH/system.prop
FILE2=$MODPATH/service.sh
if [ "$PROP" == 0 ]; then
  ui_print "- Removing ro.product.name changes..."
  sed -i 's/ro.product.name=cepheus//g' $FILE
  sed -i 's/resetprop ro.product.miname cepheus//g' $FILE2
  ui_print " "
elif [ "$PROP" ] && [ "$PROP" != 1 ]; then
  ui_print "- Your ro.product.name will be changed to $PROP"
  sed -i "s/cepheus/$PROP/g" $FILE
  sed -i "s/cepheus/$PROP/g" $FILE2
  ui_print " "
else
  ui_print "- Your ro.product.name will be changed to cepheus"
  ui_print " "
fi

# code
NAME=ro.miui.ui.version.code
if getprop | grep -Eq "miui.code\]: \[0"; then
  ui_print "- Removing $NAME..."
  sed -i "s/resetprop $NAME/#resetprop $NAME/g" $FILE2
  ui_print " "
fi

# function
patch_file() {
  ui_print "- Patching"
  ui_print "$FILE"
  ui_print "  changing $PROP"
  ui_print "  to $MODPROP"
  ui_print "  Please wait..."
  sed -i "s/$PROP/$MODPROP/g" $FILE
  sed -i "s/$PROP/$MODPROP/g" $FILE2
  ui_print " "
}

# patch
FILE=`find $MODPATH/system -type f -name libnexeditorsdk.so`
if [ "$PROP" != 0 ]; then
  PROP=ro.product.device
  MODPROP=ro.product.miname
  patch_file
fi
FILE=`find $MODPATH/system -type f -name libnex*.so`
if ! getprop | grep -Eq "miui.patch\]: \[0"; then
  PROP=ro.product.manufacturer
  MODPROP=ro.product.miui.gallery
  patch_file
fi







