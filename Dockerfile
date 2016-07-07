FROM alpine:3.4

# Which version of awscli to install.
# If you change this, you must also change Makefile and circle.yml.
ENV VERSION 1.10.45

ARG BUILD_DATE
ARG VCS_REF

LABEL \
    io.github.jumanjiman.version=$VERSION \
    io.github.jumanjiman.build-date=$BUILD_DATE \
    io.github.jumanjiman.vcs-ref=$VCS_REF \
    io.github.jumanjiman.license="Apache License 2.0" \
    io.github.jumanjiman.docker.dockerfile="/Dockerfile" \
    io.github.jumanjiman.vcs-type="Git" \
    io.github.jumanjiman.vcs-url="https://github.com/jumanjihouse/docker-aws.git"

RUN apk upgrade --no-cache --available && \
    apk add --no-cache \
      ca-certificates \
      groff \
      less \
      python \
      py-pip \
    && pip install -Iv awscli==${VERSION} \
    && apk del --purge py-pip py-setuptools \
    && adduser -D user

USER user
WORKDIR /home/user

ENTRYPOINT ["aws"]
CMD ["help"]
