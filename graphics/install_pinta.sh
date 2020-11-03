#!/bin/bash

#/**
# * install pinta
# * simple picture editor
# *
# * @category graphics
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes pinta'
sudo apt-get install --assume-yes pinta

# create desktop shortcut
cat > ~/Desktop/pinta.desktop<<EOF
[Desktop Entry]
Name=Pinta
Comment=Easily create and edit images
GenericName=Image Editor
X-GNOME-FullName=Pinta Image Editor
Exec=pinta %F
Icon=pinta
StartupNotify=false
Terminal=false
Type=Application
Categories=Graphics;2DGraphics;RasterGraphics;GTK;
MimeType=image/bmp;image/gif;image/jpeg;image/jpg;image/pjpeg;image/png;image/svg+xml;image/tiff;image/x-bmp;image/x-gray;image/x-icb;image/x-ico;image/x-png;image/x-portable-anymap;image/x-portable-bitmap;image/x-portable-graymap;image/x-portable-pixmap;image/x-xbitmap;image/x-xpixmap;image/x-pcx;image/x-targa;image/x-tga;image/openraster;
EOF

