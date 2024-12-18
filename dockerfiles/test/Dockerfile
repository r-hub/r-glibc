
ARG CONTAINER=r-hub/failure
FROM ghcr.io/gaborcsardi/figlet AS figlet
FROM ${CONTAINER}
ARG CONTAINER
COPY --from=figlet /usr/local /usr/local

ENV CONTAINER=${CONTAINER}

# The repo must be bind mounted to the /root directory,
# and it must include the built packages in output/

USER root
WORKDIR /root

COPY tools/install-bats.sh install-bats.sh
COPY test test
RUN --mount=type=secret,id=REDHAT_ORG_RHEL9 \
    --mount=type=secret,id=REDHAT_ACTIVATION_KEY_RHEL9 \
    --mount=type=secret,id=REDHAT_ORG_RHEL8 \
    --mount=type=secret,id=REDHAT_ACTIVATION_KEY_RHEL8 \
    ::: test deps && : ----------------------------------------------- && \
    if [ "${CONTAINER}" = "redhat/ubi9" ]; then \
      subscription-manager register \
        --org `cat /run/secrets/REDHAT_ORG_RHEL9` \
        --activationkey `cat /run/secrets/REDHAT_ACTIVATION_KEY_RHEL9` && \
      sh install-bats.sh && \
      subscription-manager unregister 2>/dev/null; \
    elif [ "${CONTAINER}" = "redhat/ubi8" ]; then \
      subscription-manager register \
        --org `cat /run/secrets/REDHAT_ORG_RHEL8` \
        --activationkey `cat /run/secrets/REDHAT_ACTIVATION_KEY_RHEL8` && \
      sh install-bats.sh && \
      subscription-manager unregister 2>/dev/null; \
    else \
      sh install-bats.sh; \
    fi && \
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
