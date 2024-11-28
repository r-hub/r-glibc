# -*- Dockerfile -*-

FROM ubuntu:18.04 AS build

USER root
WORKDIR /root

RUN apt-get update && \
    apt-get install -y build-essential g++ gfortran curl \
    pkg-config

ENV TZ=UTC

RUN apt-get update && \
    apt-get install -y libreadline-dev zlib1g-dev libbz2-dev \
    liblzma-dev libpcre2-dev libssl-dev libopenblas-dev \
    libjpeg-turbo8-dev libpng-dev libtiff-dev libicu-dev \
    libcairo-dev libffi-dev

# roll our own libcurl, the original has way too many depe
RUN curl -LO https://curl.haxx.se/download/curl-8.11.0.tar.gz
RUN tar xzf curl-*.tar.gz && rm curl-*.tar.gz
RUN cd curl-* && \
    LDFLAGS="-L/opt/r-lib/lib" \
    ./configure --prefix=/opt/r-lib \
      --enable-static --disable-shared --with-openssl \
      --without-libpsl --without-brotli; \
    make && \
    make install

# Need to rebuild
# - openssl w/ a patch from
#   https://github.com/Romain-Geissler-1A/openssl/commit/37748d7e6e24247729812b9b31f5ae697a46d2a6
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
RUN curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libssl-dev_1.1.1-1ubuntu2.1.18.04.23_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libssl1.1_1.1.1-1ubuntu2.1.18.04.23_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/openssl_1.1.1-1ubuntu2.1.18.04.23_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff-dev_4.0.9-5ubuntu0.10_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff5-dev_4.0.9-5ubuntu0.10_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiff5_4.0.9-5ubuntu0.10_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libtiffxx5_4.0.9-5ubuntu0.10_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfreetype6-dev_2.8.1-2ubuntu2.2_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libfreetype6_2.8.1-2ubuntu2.2_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng-dev_1.6.34-1ubuntu0.18.04.2_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng-tools_1.6.34-1ubuntu0.18.04.2_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpng16-16_1.6.34-1ubuntu0.18.04.2_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpixman-1-0_0.34.0-2ubuntu0.1_arm64.deb && \
    curl -LO https://github.com/r-hub/r-glibc/releases/download/bionic/libpixman-1-dev_0.34.0-2ubuntu0.1_arm64.deb && \
    apt-get update && \
    apt-get install -y libjbig-dev libjbig0 libjpeg-dev libjpeg8 && \
    dpkg -i ./libssl-dev* ./libssl1* ./openssl* ./libtiff* libfreetype* libpng* libpixman* && \
    rm *.deb

RUN mkdir -p /opt/r-lib/lib && \
    cp `find /usr/ -name libgfortran.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name 'libstdc++.a'` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libgomp.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libreadline.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libz.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libbz2.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name liblzma.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name "libpcre2*.a"` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libssl.a` `find /usr/ -name libcrypto.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libopenblas.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libtinfo.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libjpeg.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libpng.a` /opt/r-lib/lib/ && \
    cp `find /usr/ -name libtiff.a` /opt/r-lib/lib/ && \
    cp `dpkg -L libicu-dev | grep '\.a$'` /opt/r-lib/lib/ && \
    cp `find /usr -name libcairo.a` /opt/r-lib/lib/ &&\
    cp `find /usr -name libffi.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libjbig.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpng16.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpixman-1.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libfontconfig.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libfreetype.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libexpat.a` /opt/r-lib/lib/ && \
    cp `find /usr -name libpng16.a` /opt/r-lib/lib/

ARG R_VERSION

# embed which into R, because it is very much needed, but some
# minimal Docker images don't have it
RUN curl -LO https://github.com/r-hub/r-musl/releases/download/v3.19/$(arch)/which-r-2.21-r4.apk && \
    tar xzf which-*.apk opt/r-lib/bin/which && \
    mkdir -p /opt/R/${R_VERSION}-glibc/lib/R/tools && \
    cp opt/r-lib/bin/which /opt/R/${R_VERSION}-glibc/lib/R/tools

RUN curl -LO https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz
RUN tar xzf R-${R_VERSION}.tar.gz

COPY dockerfiles/bionic/R-${R_VERSION}.patch .
RUN cd R-${R_VERSION} && patch -p1 < ../R-${R_VERSION}.patch
RUN cd R-${R_VERSION} && \
    PATH="/opt/R/${R_VERSION}-glibc/lib/R/tools:/opt/r-lib/bin:$PATH" \
    ./configure --with-internal-tzcode --prefix=/opt/R/${R_VERSION}-glibc --with-x=no \
    --with-blas --with-lapack --enable-BLAS-shlib=no \
    --with-included-gettext \
    --with-static-cairo \
    PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/r-lib/lib/pkgconfig" \
    BLAS_LIBS="-lopenblas -lpthread" \
    CPPFLAGS=-I/opt/r-lib/include \
    LDFLAGS=-L/opt/r-lib/lib

RUN cd R-${R_VERSION} && make
RUN cd R-${R_VERSION} && make install

# patch to embed CA certs
RUN curl -L https://curl.se/ca/cacert.pem -o /opt/R/${R_VERSION}-glibc/lib/R/share/curl-ca-bundle.crt
RUN echo "CURL_CA_BUNDLE=${CURL_CA_BUNDLE-/opt/R/${R_VERSION}-glibc/lib/R/share/curl-ca-bundle.crt}" \
    >> /opt/R/${R_VERSION}-glibc/lib/R/etc/Renviron

# strip
RUN for f in `find /opt/R/${R_VERSION}-glibc/ -executable -type f `; do strip -x "$f" || true; done

FROM ubuntu:18.04 AS final
COPY --from=build /opt/R /opt/R

USER root
WORKDIR /root

ENV TZ=UTC

# Some of this info is shown on the GH packages pages
LABEL org.opencontainers.image.source="https://github.com/r-hub/r-musl"
LABEL org.opencontainers.image.description="Self-contained R build for GNU/Linux"
LABEL org.opencontainers.image.authors="https://github.com/gaborcsardi"
