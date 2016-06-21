FROM alpine:3.4

# Which version of awscli to install.
# If you change this, you must also change Makefile and circle.yml.
ENV VERSION 1.10.38

ARG BUILD_DATE
ARG VCS_REF

LABEL \
    io.jumanjiman.github.version=$VERSION \
    io.jumanjiman.github.build-date=$BUILD_DATE \
    io.jumanjiman.github.vcs-ref=$VCS_REF \
    io.jumanjiman.github.license="Apache License 2.0" \
    io.jumanjiman.github.docker.dockerfile="/Dockerfile" \
    io.jumanjiman.github.vcs-type="Git" \
    io.jumanjiman.github.vcs-url="https://github.com/jumanjihouse/docker-aws.git"

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
