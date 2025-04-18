# -*- Dockerfile -*- ------------------------------------------------------

FROM ubuntu:18.04 AS download

USER root
WORKDIR /root

RUN apt-get update && \
    apt-get install -y build-essential g++ gfortran curl \
    pkg-config

ENV TZ=UTC

RUN apt-get update && \
    apt-get install -y libreadline-dev zlib1g-dev libbz2-dev \
    liblzma-dev libpcre2-dev libopenblas-dev \
    libjpeg-turbo8-dev libpng-dev libtiff-dev libicu-dev \
    libcairo-dev libffi-dev libpango1.0-dev libthai-dev \
    libdatrie-dev texinfo libxt-dev uuid-dev libbsd-dev

# this is neeeed for openssl to compile on x86_64
RUN export ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libgcc-7-dev_7.5.0-3ubuntu1.18.04_$ARCH.deb && \
      apt-get update && \
      dpkg -i ./libgcc* || true && \
      rm *.deb && \
      apt-get -f -y install && \
      dpkg -s libgcc-7-dev >/dev/null 2>/dev/null; \
    fi

# use a newer openssl, for security
RUN curl -LO https://github.com/openssl/openssl/releases/download/openssl-3.4.1/openssl-3.4.1.tar.gz
RUN tar xzf openssl-3.4.1.tar.gz && rm openssl-3.4.1.tar.gz
RUN cd openssl-* && \
    CFLAGS="-fPIC" ./config -fPIC no-shared --prefix=/opt/r-lib && \
    make && \
    make install_sw

# not all R versions will find libssl.a in /opt/r-lib/lib64, move it
RUN mkdir -p /opt/r-lib/lib && \
    cp /opt/r-lib/lib64/*.a /opt/r-lib/lib/ || true

# roll our own libcurl, the original has way too many depe
RUN curl -LO https://curl.haxx.se/download/curl-8.11.0.tar.gz
RUN tar xzf curl-*.tar.gz && rm curl-*.tar.gz
RUN cd curl-* && \
    LDFLAGS="-L/opt/r-lib/lib" \
    ./configure --prefix=/opt/r-lib \
      --enable-static --disable-shared --with-openssl=/opt/r-lib \
      --without-libpsl --without-brotli; \
    make && \
    make install

# Need to rebuild
# - libtiff with
# --- tiff-4.0.9/debian/rules	2018-04-15 18:13:42.000000000 +0000
# +++ tiff-4.0.9-new/debian/rules	2024-11-27 16:25:15.920000132 +0000
# @@ -6,7 +6,8 @@
#
#  # Enable all hardening options.
#  export DEB_BUILD_MAINT_OPTIONS = hardening=+all
# -export DEB_CFLAGS_MAINT_APPEND  = -Wall -pedantic -D_REENTRANT
# +export DEB_CFLAGS_MAINT_APPEND  = -Wall -pedantic -D_REENTRANT -fPIC
# +export DEB_CXXFLAGS_MAINT_APPEND  = -fPIC
#  export DEB_LDFLAGS_MAINT_APPEND = -Wl,--as-needed
#
#   # Variables used by cdbs
RUN export ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "arm64" ]; then \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff-dev_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff5-dev_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff5_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiffxx5_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfreetype6-dev_2.8.1-2ubuntu2.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfreetype6_2.8.1-2ubuntu2.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng-dev_1.6.34-1ubuntu0.18.04.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng-tools_1.6.34-1ubuntu0.18.04.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng16-16_1.6.34-1ubuntu0.18.04.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpixman-1-0_0.34.0-2ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpixman-1-dev_0.34.0-2ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpango1.0-dev_1.40.14-1ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libglib2.0-dev_2.56.4-0ubuntu0.18.04.9_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libgraphite2-dev_1.3.11-2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxdmcp-dev_1.1.2-3_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxt-dev_1.1.5-1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libsm-dev_1.2.2-1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libx11-dev_1.6.4-3ubuntu0.4_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libbsd-dev_0.8.7-1ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxrender-dev_0.9.10-1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxext-dev_1.3.3-1_$ARCH.deb && \
      apt-get update && \
      apt-get install -y libjbig-dev libjbig0 libjpeg-dev libjpeg8 && \
      dpkg -i ./libtiff* libfreetype* \
        libpng* libpixman* libpango* libglib* libgraphite2* libxdmcp* \
        libxt* libsm* libx11* libbsd* libxrender* libxext* && \
      rm *.deb; \
    fi

RUN export ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/zlib1g-dev_1.2.11.dfsg-0ubuntu2.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/zlib1g_1.2.11.dfsg-0ubuntu2.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpixman-1-dev_0.34.0-2ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpixman-1-dev_0.34.0-2ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfreetype6_2.8.1-2ubuntu2.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfreetype6-dev_2.8.1-2ubuntu2.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff-dev_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff5-dev_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff5_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiffxx5_4.0.9-5ubuntu0.10_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libjbig-dev_2.1-3.1ubuntu0.18.04.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libjbig0_2.1-3.1ubuntu0.18.04.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libjpeg-turbo8_1.5.2-0ubuntu5.18.04.6_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libjpeg-turbo8-dev_1.5.2-0ubuntu5.18.04.6_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/liblzma-dev_5.2.2-1.3ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/liblzma5_5.2.2-1.3ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng-dev_1.6.34-1ubuntu0.18.04.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng-tools_1.6.34-1ubuntu0.18.04.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng16-16_1.6.34-1ubuntu0.18.04.2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfontconfig1-dev_2.12.6-0ubuntu2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfontconfig1_2.12.6-0ubuntu2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libexpat1-dev_2.2.5-3ubuntu0.9_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libexpat1_2.2.5-3ubuntu0.9_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libcairo2-dev_1.15.10-2ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libcairo2_1.15.10-2ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libgfortran-7-dev_7.5.0-3ubuntu1.18.04_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libgraphite2-dev_1.3.11-2_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpango1.0-dev_1.40.14-1ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libharfbuzz-dev_1.7.2-1ubuntu1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libdatrie-dev_0.2.10-7_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpcre3-dev_8.39-9ubuntu0.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libglib2.0-dev_2.56.4-0ubuntu0.18.04.9_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libsm-dev_1.2.2-1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxext-dev_1.3.3-1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libx11-dev_1.6.4-3ubuntu0.4_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxt-dev_1.1.5-1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libice-dev_1.0.9-2ubuntu0.18.04.1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxrender-dev_0.9.10-1_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxcb1-dev_1.13-2.ubuntu18.04_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libxdmcp-dev_1.1.2-3_$ARCH.deb && \
      curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libbsd-dev_0.8.7-1ubuntu0.1_$ARCH.deb && \
      dpkg -i ./zlib* libpixman* libfreetype6* libtiff* libjbig* \
        libjpeg* liblzma* libpng* libfontconfig* libexpat* libcairo* \
        libgfortran* libgraphite2* libpango* libharfbuzz* libdatrie* libpcre3* \
        libglib* libsm* libxext* libx11* libxt* libice* libxrender* libxcb1* libxdmcp* \
        libbsd* && \
      rm *.deb; \
    fi

RUN mkdir -p /opt/r-lib/lib && \
    export ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
      cp `find /usr/ -name libquadmath.a` /opt/r-lib/lib/ ; \
    fi && \
    cp `find /usr/ -name libgfortran.a` /opt/r-lib/lib/ ; \
    cp `find /usr/ -name 'libstdc++.a'` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libgomp.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libreadline.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libz.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libbz2.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name liblzma.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name "libpcre*.a"` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libopenblas.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libtinfo.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libjpeg.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libpng.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libtiff.a` /opt/r-lib/lib/ && \
    cp `dpkg -L libicu-dev | grep '\.a$'` /opt/r-lib/lib/ && \
    cp `find /usr -name libffi.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libjbig.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpng16.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpixman-1.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libfontconfig.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libfreetype.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libexpat.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpng16.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libcairo.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpangocairo-1.0.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpango-1.0.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libgobject-2.0.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpangoft2-1.0.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libharfbuzz.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libglib-2.0.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libgraphite2.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libthai.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libdatrie.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libtermcap.a` /opt/r-lib/lib/ && \
    ln -s libthai.pc /usr/lib/$(arch)-linux-gnu/pkgconfig/thai.pc && \
    cp `find /usr -name libXt.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libSM.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libICE.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libX11.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libuuid.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libbsd.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libxcb.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libXau.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libXdmcp.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libXrender.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libXext.a` /opt/r-lib/lib/


ARG R_VERSION

# embed which into R, because it is very much needed, but some
# minimal Docker images don't have it
RUN curl -LO https://github.com/r-hub/r-musl/releases/download/v3.19/$(arch)/which-r-2.21-r4.apk && \
    tar xzf which-*.apk opt/r-lib/bin/which && \
    mkdir -p /opt/R/${R_VERSION}-glibc/lib/R/tools && \
    cp opt/r-lib/bin/which /opt/R/${R_VERSION}-glibc/lib/R/tools

# embed a static build of less, to always have a decent PAGER
RUN curl -LO https://github.com/r-hub/r-musl/releases/download/v3.19/$(arch)/less-r-643-r2.apk && \
    tar xzf less-*.apk opt/r-lib/bin/less && \
    mkdir -p /opt/R/${R_VERSION}-glibc/lib/R/tools && \
    cp opt/r-lib/bin/less /opt/R/${R_VERSION}-glibc/lib/R/tools

# also info some term info files, might not be present on minimal containers
# need to set an env var to point to them, see below
RUN cp -r /lib/terminfo /opt/R/${R_VERSION}-glibc/lib/R/

# static zip and unzip, in case they are not available
RUN curl -LO https://github.com/r-hub/r-musl/releases/download/v3.19/$(arch)/unzip-r-6.0-r14.apk && \
    curl -LO https://github.com/r-hub/r-musl/releases/download/v3.19/$(arch)/zip-r-3.0-r12.apk && \
    tar xzf unzip-*.apk opt/r-lib/bin/unzip && \
    tar xzf zip-*.apk opt/r-lib/bin/zip && \
    mkdir -p /opt/R/${R_VERSION}-glibc/lib/R/tools && \
    cp opt/r-lib/bin/unzip opt/r-lib/bin/zip /opt/R/${R_VERSION}-glibc/lib/R/tools

# libdeflate is not in Bionic, so install separately.
# Only needed for R >= 4.4.0, so do it late (=here), for better caching
# over R versions.
RUN if dpkg --compare-versions ${R_VERSION} ge 4.4.0; then \
      apt-get update && apt-get install -y cmake && \
      curl -LO https://github.com/ebiggers/libdeflate/releases/download/v1.23/libdeflate-1.23.tar.gz && \
      tar xzf libdeflate-1.23.tar.gz && \
      rm libdeflate-1.23.tar.gz && \
      cd libdeflate-1.23 && \
      mkdir -p build && \
      cd build && \
      cmake .. && \
      make && \
      make install && \
      cp /usr/local/lib/libdeflate.a /opt/r-lib/lib/; \
    fi

# R should not default to linking to /opt/r-lib, so create some symlinks
RUN mkdir -p /opt/R/${R_VERSION}-glibc/lib/R && \
    ln -s /opt/r-lib/lib /opt/R/${R_VERSION}-glibc/lib/R/ && \
    ln -s /opt/r-lib/include /opt/R/${R_VERSION}-glibc/lib/R/

RUN if [ "${R_VERSION}" = "devel" ]; then \
      curl -LO https://cran.r-project.org/src/base-prerelease/R-devel.tar.gz; \
    elif [ "${R_VERSION}" = "next" ]; then \
      curl -LO https://cran.rstudio.com/src/base-prerelease/R-patched.tar.gz; \
      mv R-patched.tar.gz R-next.tar.gz; \
    else \
      curl -LO https://cran.r-project.org/src/base/R-${R_VERSION%*.*.*}/R-${R_VERSION}.tar.gz; \
    fi
RUN tar xzf R-${R_VERSION}.tar.gz
RUN if [ -e R-patched ]; then mv R-patched R-next; fi
RUN if [ -e R-beta ]; then mv R-beta R-next; fi
RUN if [ -e R-alpha ]; then mv R-alpha R-next; fi
RUN if [ -e R-rc ]; then mv R-rc R-next; fi
RUN if [ -e R-prerelease ]; then mv R-prerelease R-next; fi
RUN if [ -e R-pre ]; then mv R-pre R-next; fi

FROM download AS patch

ENV R_VERSION=${R_VERSION}
COPY dockerfiles/bionic/R-${R_VERSION}.patch .
RUN cd R-${R_VERSION} && patch -p1 < ../R-${R_VERSION}.patch
RUN echo "TERMINFO=\${TERMINFO-/opt/R/${R_VERSION}-glibc/lib/R/terminfo}" \
    >> R-${R_VERSION}/etc/Renviron.in

FROM patch AS configure

RUN cd R-${R_VERSION} && \
    PATH="/opt/R/${R_VERSION}-glibc/lib/R/tools:/opt/r-lib/bin:$PATH" \
    ./configure --with-internal-tzcode --prefix=/opt/R/${R_VERSION}-glibc --with-x=no \
    --with-blas --with-lapack --enable-BLAS-shlib=no \
    --with-included-gettext \
    --with-static-cairo \
    --with-x \
    PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/R/${R_VERSION}-glibc/lib/R/lib/pkgconfig" \
    BLAS_LIBS="-lopenblas -lm -lpthread" \
    CPPFLAGS=-I/opt/R/${R_VERSION}-glibc/lib/R/include \
    LDFLAGS=-L/opt/R/${R_VERSION}-glibc/lib/R/lib \
    PAGER=/opt/R/${R_VERSION}-glibc/lib/R/tools/less \
    R_ZIPCMD=/opt/R/${R_VERSION}-glibc/lib/R/tools/zip \
    R_UNZIPCMD=/opt/R/${R_VERSION}-glibc/lib/R/tools/unzip \
    R_BROWSER=xdg-open \
    R_PDFVIEWER=xdg-open \
    R_PRINTCMD=lpr

FROM configure AS build

RUN cd R-${R_VERSION} && make

# remove the temporary symlinks
RUN rm /opt/R/${R_VERSION}-glibc/lib/R/include \
    /opt/R/${R_VERSION}-glibc/lib/R/lib
RUN cd R-${R_VERSION} && make install

# embed openblas static lib
RUN mkdir -p /opt/R/${R_VERSION}-glibc/lib/R/lib && \
    cp /opt/r-lib/lib/libopenblas.a /opt/R/${R_VERSION}-glibc/lib/R/lib/

# patch to embed CA certs
RUN curl -L https://curl.se/ca/cacert.pem -o /opt/R/${R_VERSION}-glibc/lib/R/share/curl-ca-bundle.crt
RUN echo "CURL_CA_BUNDLE=${CURL_CA_BUNDLE-/opt/R/${R_VERSION}-glibc/lib/R/share/curl-ca-bundle.crt}" \
    >> /opt/R/${R_VERSION}-glibc/lib/R/etc/Renviron

# strip debug symbols by default
RUN echo "_R_SHLIB_STRIP_=${_R_SHLIB_STRIP_-true}" \
    >> /opt/R/${R_VERSION}-glibc/lib/R/etc/Renviron

# strip
RUN for f in `find /opt/R/${R_VERSION}-glibc/ -executable -type f `; do strip -x "$f" || true; done

# -------------------------------------------------------------------------

FROM ghcr.io/gaborcsardi/figlet AS figlet
FROM ubuntu:18.04 AS test
COPY --from=figlet /usr/local /usr/local

COPY tools/install-bats.sh install-bats.sh
RUN ::: test deps && : ----------------------------------------------- && \
    sh install-bats.sh && \
    ----- # ---------------------------------------------------------------

ARG R_VERSION
COPY --from=build /opt/R /opt/R
RUN ln -sf /opt/R/${R_VERSION}-glibc/bin/R /usr/local/bin/
COPY test test
RUN ::: TESTS && : --------------------------------------------------- && \
    mkdir -p /root/test-results && \
    cd test && \
    bats -o /root/test-results --timing . && \
    ----- # ---------------------------------------------------------------

# =========================================================================

FROM ubuntu:18.04 AS package
ARG R_VERSION
COPY --from=figlet /usr/local /usr/local
COPY --from=build /opt/R /opt/R
COPY --from=test /root/test-results /root/test-results

RUN ::: TAR.GZ package && : ------------------------------------------ && \
    tar czf r-${R_VERSION}-glibc-$(arch).tar.gz \
      /opt/R/${R_VERSION}-glibc/ && \
    mkdir -p /root/output && \
    mv r-${R_VERSION}-glibc-$(arch).tar.gz /root/output && \
    ----- # ---------------------------------------------------------------

RUN ::: nfpm packager && : ------------------------------------------- && \
    apt-get update && \
    apt-get install -y gettext-base curl

RUN curl -LO "https://github.com/goreleaser/nfpm/releases/download/v2.41.1/nfpm_2.41.1_$(dpkg --print-architecture).deb" && \
    apt install -y ./nfpm_*.deb && \
    rm nfpm_*.deb && \
    ----- # ---------------------------------------------------------------

COPY tools/package-deb.yml.in package-deb.yml.in
RUN ::: DEB package && : --------------------------------------------- && \
    export R_VERSION=${R_VERSION} && \
    export ARCH="`dpkg --print-architecture`" && \
    cat package-deb.yml.in | envsubst | tee package-deb.yml
RUN nfpm package \
      -f package-deb.yml \
      -p deb \
      -t /root/output && \
    ----- # ---------------------------------------------------------------

COPY tools/package-rpm.yml.in package-rpm.yml.in
RUN ::: RPM package && : --------------------------------------------- && \
    export R_VERSION=${R_VERSION} && \
    export ARCH="`dpkg --print-architecture`" && \
    cat package-rpm.yml.in | envsubst | tee package-rpm.yml
RUN nfpm package \
      -f package-rpm.yml \
      -p rpm \
      -t /root/output && \
    ----- # ---------------------------------------------------------------
