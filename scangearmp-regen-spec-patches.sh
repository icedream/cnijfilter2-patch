#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEPATH=$(pwd)

# download
if [ ! -f ./scangearmp2-source-3.90-1.tar.gz ]; then
  curl --fail -sLo ./scangearmp2-source-3.90-1.tar.gz "https://gdlp01.c-wss.com/gds/7/0100010487/01/scangearmp2-source-3.90-1.tar.gz"
fi

# unpack
tar -vxf ./scangearmp2-source-3.90-1.tar.gz scangearmp2-source-3.90-1/scangearmp2.spec

# generate patches
diff -u scangearmp2-source-3.90-1/*.spec scangearmp2-source-3.90-1.new/*.spec | tee patches/scangearmp2/spec.patch
