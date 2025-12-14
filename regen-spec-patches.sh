#!/usr/bin/env bash

set -e
set -u
set -o pipefail

BASEPATH=$(pwd)

# download
if [ ! -f ./cnijfilter2-source-5.90-1.tar.gz ]; then
  curl --fail -sLo ./cnijfilter2-source-5.90-1.tar.gz "https://gdlp01.c-wss.com/gds/4/0100010484/01/cnijfilter2-source-5.90-1.tar.gz"
fi

# unpack
tar -vxf ./cnijfilter2-source-5.90-1.tar.gz cnijfilter2-source-5.90-1/cnijfilter2.spec

# generate patches
diff -u cnijfilter2-source-5.90-1/*.spec cnijfilter2-source-5.90-1.new/*.spec | tee patches/cnijfilter2/spec.patch
