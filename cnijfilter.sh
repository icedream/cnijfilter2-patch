#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEPATH=$(pwd)

# deps
sudo dnf install -y fedora-packager gcc g++ autoconf automake libtool cups-devel glib2-devel glib-gettextize libusb-compat-0.1-devel gettext-devel libxml2-devel glib-gettextize

# download
curl --fail -sLo ./cnijfilter2-source-5.90-1.tar.gz "https://gdlp01.c-wss.com/gds/4/0100010484/01/cnijfilter2-source-5.90-1.tar.gz"

# unpack
rm -rf cnijfilter2-source-5.90-1
tar -xf ./cnijfilter2-source-5.90-1.tar.gz

# apply patches
(
  cd cnijfilter2-source-5.90-1
  for patch in "$BASEPATH/patches/cnijfilter2"/aur/*.patch "$BASEPATH/patches/cnijfilter2"/gentoo/*.patch "$BASEPATH/patches/cnijfilter2"/*.patch; do
    patch -Np1 -i "$patch"
  done
)
#exit 0

# rebuild
mkdir -p ~/rpmbuild/SOURCES/
tar -czvf ~/rpmbuild/SOURCES/cnijfilter2-source-5.90-1.tar.gz cnijfilter2-source-5.90-1
rpmbuild -tb ~/rpmbuild/SOURCES/cnijfilter2-source-5.90-1.tar.gz
rm -rf cnijfilter2-source-5.90-1
