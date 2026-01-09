#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEPATH=$(pwd)

# deps
sudo dnf install -y rpm-build gcc g++ autoconf automake libtool gtk2-devel

# download
curl --fail -sLo ./scangearmp2-source-3.90-1.tar.gz "https://gdlp01.c-wss.com/gds/7/0100010487/01/scangearmp2-source-3.90-1.tar.gz"

# unpack
rm -rf scangearmp2-source-3.90-1
tar -xf ./scangearmp2-source-3.90-1.tar.gz

# apply patches
(
  cd scangearmp2-source-3.90-1
  for patch in "$BASEPATH/patches/scangearmp2"/*.patch; do
    patch -Np1 -i "$patch"
  done
)
#exit 0

# rebuild
mkdir -p ~/rpmbuild/SOURCES/
tar -czvf ~/rpmbuild/SOURCES/scangearmp2-source-3.90-1.tar.gz scangearmp2-source-3.90-1
rpmbuild -tb ~/rpmbuild/SOURCES/scangearmp2-source-3.90-1.tar.gz
rm -rf scangearmp2-source-3.90-1
