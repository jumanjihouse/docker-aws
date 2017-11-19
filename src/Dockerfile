FROM alpine:3.6

ARG VERSION

RUN apk upgrade --no-cache --available && \
    apk add --no-cache \
      ca-certificates \
      groff \
      less \
      python \
      && \
    apk add --no-cache --virtual dev py2-pip && \
    ( \
      [[ ${VERSION} = latest ]] && \
      pip install -Iv --compile --no-cache-dir awscli || \
      pip install -Iv --compile --no-cache-dir awscli==${VERSION} \
    ) && \
    apk del --purge dev \
    && adduser -D user

USER user
WORKDIR /home/user

ENTRYPOINT ["aws"]
CMD ["help"]

# These values change frequently.
# Put them last in the Dockerfile
# to preserve the build cache.
ARG CI_BUILD_URL
ARG BUILD_DATE
ARG VCS_REF
LABEL \
    io.github.jumanjiman.ci-build-url=${CI_BUILD_URL} \
    io.github.jumanjiman.version=${VERSION} \
    io.github.jumanjiman.build-date=${BUILD_DATE} \
    io.github.jumanjiman.vcs-ref=${VCS_REF} \
    io.github.jumanjiman.license="Apache License 2.0" \
    io.github.jumanjiman.docker.dockerfile="/src/Dockerfile" \
    io.github.jumanjiman.vcs-type="Git" \
    io.github.jumanjiman.vcs-url="https://github.com/jumanjihouse/docker-aws.git"
