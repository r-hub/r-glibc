#! /bin/sh

set -e

if command -v apt-get; then
    apt-get update &&
	apt-get install -y curl patchelf file gcc make libc6-dev g++ gfortran
elif command -v dnf; then
    dnf install -y epel-release || true # might be needed, might be not
    dnf install -y --allowerasing curl file gcc make glibc-devel gcc-c++ gcc-gfortran
elif command -v yum; then
    yum install -y epel-release || true # might be needed, might be not
    yum install -y curl file gcc make glibc-devel gcc-c++ gcc-gfortran
elif command -v zypper; then
    # glibc-locale-base is actually needed on OpenSUSE currently, to install
    # packages with a latin1 DESCRIPTION
    zypper --non-interactive install curl file gcc make \
	   glibc-devel gcc-c++ gcc-fortran tar gzip glibc-locale-base
else
    >&2 echo Cannot install bats on this platform
    exit 1
fi
	
curl -LO https://github.com/bats-core/bats-core/archive/refs/tags/v1.11.0.tar.gz
tar xzf v1.11.0.tar.gz
cd bats-core-*
./install.sh /usr/local/
cd ..
rm -rf bats-core-* v1.11.0.tar.gz
bats --version
