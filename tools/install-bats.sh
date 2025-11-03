#! /bin/sh

set -e

if command -v apt-get; then
    apt-get update &&
	apt-get install -y curl patchelf file gcc make libc6-dev g++ \
        gfortran xvfb
elif command -v dnf; then
    dnf install -y epel-release || true # might be needed, might be not
    dnf install -y --allowerasing curl file gcc make glibc-devel \
        gcc-c++ gcc-gfortran
    # RHEL 10 & similar has no xvfb, but there is a replacement
    dnf install -y xorg-x11-server-Xvfb || dnf install -y xwayland-run
    if ! command -v xvfb-run; then ln -s `command -v xwfb-run` /usr/local/bin/xvfb-run; fi
elif command -v yum; then
    yum install -y epel-release || true # might be needed, might be not
    yum install -y curl file gcc make glibc-devel gcc-c++ gcc-gfortran \
        xorg-x11-server-Xvfb
elif command -v zypper; then
    # glibc-locale-base is actually needed on OpenSUSE currently, to install
    # packages with a latin1 DESCRIPTION
    zypper --non-interactive install curl file gcc make \
	   glibc-devel gcc-c++ gcc-fortran tar gzip glibc-locale-base \
       xorg-x11-server-Xvfb
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
