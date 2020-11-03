#!/bin/bash

#/**
# * install gimp
# * gnu image manipulation program
# *
# * @category graphics
# * @link     https://www.gimp.org
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gimp'
sudo apt-get install --assume-yes gimp

# create desktop shortcut
cat > ~/Desktop/gimp.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=GNU Image Manipulation Program
GenericName=Image Editor
Comment=Create images and edit photographs
# Translators: Search terms to find this application. Do NOT translate or localize the semicolons! The list MUST also end with a semicolon!
Keywords=GIMP;graphic;design;illustration;painting;
Exec=gimp-2.10 %U
TryExec=gimp-2.10
Icon=gimp
Terminal=false
Categories=Graphics;2DGraphics;RasterGraphics;GTK;
X-GNOME-Bugzilla-Bugzilla=GNOME
X-GNOME-Bugzilla-Product=GIMP
X-GNOME-Bugzilla-Component=General
X-GNOME-Bugzilla-Version=2.10.8
X-GNOME-Bugzilla-OtherBinaries=gimp-2.10
StartupNotify=true
MimeType=image/bmp;image/g3fax;image/gif;image/x-fits;image/x-pcx;image/x-portable-anymap;image/x-portable-bitmap;image/x-portable-graymap;image/x-portable-pixmap;image/x-psd;image/x-sgi;image/x-tga;image/x-xbitmap;image/x-xwindowdump;image/x-xcf;image/x-compressed-xcf;image/x-gimp-gbr;image/x-gimp-pat;image/x-gimp-gih;image/tiff;image/jpeg;image/x-psp;application/postscript;image/png;image/x-icon;image/x-xpixmap;image/x-exr;image/x-webp;image/heif;image/heic;image/svg+xml;application/pdf;image/x-wmf;image/jp2;image/x-xcursor;
X-Ubuntu-Gettext-Domain=gimp20
EOF

