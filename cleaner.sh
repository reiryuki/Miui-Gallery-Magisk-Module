PKG=com.miui.gallery
for PKGS in $PKG; do
  rm -rf /data/user/*/$PKGS/cache/*
done


