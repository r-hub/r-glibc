# Generic Linux build of R

> r-glibc is a generic build of R, that works on any (recent) GNU libc
> based Linux distribution.

> [!WARNING]
> Note that r-glibc is experimental currently.

## Supported Linux systems

r-glibc _should_ work out of the box without additional dependencies
on any Linux platform that uses GNU libc 2.27 or newer.
These include most systems in use today. We regularly test it on these
following platforms:

* Ubuntu Linux 18.04, 20.04, 22.04, 24.04.
* Debian Linux 11, 12,
* AlmaLinux 8, 9,
* Rocky Linux 8, 9,
* RedHat Enterprise Linux 8, 9,
* OpenSUSE Leap 15.5, 15.6 <sup>*</sup>,
* SUSE Linux Enterprise 15 SP5, SP6 <sup>*</sup>,
* Fedora Linux 39, 40, 41.

<small>
* On OpenSUSE and SUSE Linux Enterprise systems R packages that use the
ISO Latin 1 character encoding need the <code>glibc-locale-base</code>
package installed. Install it with <code>zypper install
glibc-locale-base</code>.
</small>

## Architectures

We have `x86_64` and `aarch64` builds.

## Supported R versions

* R 3.6.0 to R 4.4.2.
* Daily development snapshot (`devel`).
* Daily snapshot of the next (patched, beta, alpha or RC) version of
  R (`next`).
* List of all supported versions:
  • `3.6.0` • `3.6.1` • `3.6.2` • `3.6.3`
  • `4.0.0` • `4.0.1` • `4.0.2` • `4.0.3` • `4.0.4` • `4.0.5`
  • `4.1.0` • `4.1.1` • `4.1.2` • `4.1.3`
  • `4.2.0` • `4.2.1` • `4.2.2` • `4.2.3`
  • `4.3.0` • `4.3.1` • `4.3.2` • `4.3.3`
  • `4.4.0` • `4.4.1` • `4.4.2`
  • `next` • `devel`.

More versions are coming soon ([#13](
  https://github.com/r-hub/r-glibc/issues/13)).

## Known limitations

* No X11 support ([#18](https://github.com/r-hub/r-glibc/issues/18)).
* `bmp()`, `png()`, `tiff()`, `jpeg()` default to `type = "Xlib"` so they
  don't work without an explicit `type = "cairo"` argument ([#15](
  https://github.com/r-hub/r-glibc/issues/15)).
* No built-in libdeflate support ([#12](
  https://github.com/r-hub/r-glibc/issues/12)).
* The built-in fontconfig library might not work with the system's
  fonts ([#19](https://github.com/r-hub/r-glibc/issues/19)).
* The included system libraries are relatively old ([#20](
  https://github.com/r-hub/r-glibc/issues/20)).
* The available R versions are limited currently ([#13](
  https://github.com/r-hub/r-glibc/issues/13)).
* r-glibc does not work on platforms that do not use GNU libc, e.g. on
  Alpine Linux.

Please [open an issue](https://github.com/r-hub/r-glibc/issues) if you
think that r-glibc does not work as promised.

## Installation

Watch [this issue](https://github.com/r-lib/rig/issues/258) in the
rig repository if you would like to install these builds with rig.

### Debian or Ubuntu based platforms

Replace `4.4.2` with the R version you want to install.

```sh
R_VERSION=4.4.2
curl -LO https://github.com/r-hub/R/releases/download/v${R_VERSION}/r-${R_VERSION}-glibc_1_$(dpkg --print-architecture).deb
dpkg -i r-${R_VERSION}-glibc_1_$(dpkg --print-architecture).deb
ln -s /opt/R/${R_VERSION}-glibc/bin/R /usr/local/bin
```

### Fedora, RHEL or other RPM based distributions

```sh
R_VERSION=4.4.2
yum install https://github.com/r-hub/R/releases/download/v${R_VERSION}/R-${R_VERSION}-glibc-1-1.$(arch).rpm
ln -s /opt/R/${R_VERSION}-glibc/bin/R /usr/local/bin
```

### OpenSUSE

```sh
R_VERSION=4.4.2
zypper install glibc-locale-base
zypper install --allow-unsigned-rpm https://github.com/r-hub/R/releases/download/v${R_VERSION}/R-${R_VERSION}-glibc-1-1.$(arch).rpm
ln -s /opt/R/${R_VERSION}-glibc/bin/R /usr/local/bin
```

### Other GNU libc Linux platforms

```sh
R_VERSION=4.4.2
curl -Ls https://github.com/r-hub/R/releases/download/v${R_VERSION}/r-${R_VERSION}-glibc-$(arch).tar.gz |
  tar xz -C /
ln -s /opt/R/${R_VERSION}-glibc/bin/R /usr/local/bin
```

### R packages and system dependencies

While the r-glibc builds are dependency-free, some R packages require
the installation of system packages. I suggest you use [pak](
  https://pak.r-lib.org) and it's [automatic system dependency installation
system](https://pak.r-lib.org/reference/sysreqs.html) to automate system
package installation, if pak supports your platform.

### Multiple versions

r-glibc is designed to allow installing multiple versions of R, side by
side. You can set a symbolic link at `/usr/local/bin/R` to the version
you would like to use by default. Watch [this issue](
  https://github.com/r-lib/rig/issues/258) if you would like to have a
way to automated this with rig.

## License

See <https://www.r-project.org/Licenses/> for the R licenses

These Dockerfiles and tools are licensed under the MIT License.

© [Posit Software, PBC](https://posit.co/)
