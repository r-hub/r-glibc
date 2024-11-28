#! /bin/sh

set -e

curl -LO https://github.com/bats-core/bats-core/archive/refs/tags/v1.11.0.tar.gz
tar xzf v1.11.0.tar.gz
cd bats-core-*
./install.sh /usr/local/
cd ..
rm -rf bats-core-* v1.11.0.tar.gz
bats --version
