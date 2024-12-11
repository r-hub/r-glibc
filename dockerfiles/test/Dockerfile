
ARG CONTAINER=r-hub/failure
FROM ghcr.io/gaborcsardi/figlet AS figlet
FROM ${CONTAINER}
COPY --from=figlet /usr/local /usr/local

# The repo must be bind mounted to the /root directory,
# and it must include the built packages in output/

USER root
WORKDIR /root

COPY tools/install-bats.sh install-bats.sh
COPY test test
RUN ::: test deps && : ----------------------------------------------- && \
    sh install-bats.sh && \
    ----- # ---------------------------------------------------------------

COPY output output
RUN ::: install R && : ----------------------------------------------- && \
    if command -v rpm; then \
      rpm -i output/R-*-glibc*.rpm; \
    elif command -v dpkg; then \
      dpkg -i output/r-*glibc*.deb; \
    fi && \
    ln -s /opt/R/*/bin/R /usr/local/bin/ && \
    ----- # ---------------------------------------------------------------

RUN ::: run tests && : ----------------------------------------------- && \
    cd test && bats --timing . && \
    ----- # ---------------------------------------------------------------
