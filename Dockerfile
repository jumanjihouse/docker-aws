FROM alpine:latest

# Which version of awscli to install.
# If you change this, you must also change Makefile and circle.yml.
ENV VERSION 1.9.3

RUN apk upgrade --update --available && \
    apk add \
      ca-certificates \
      groff \
      less \
      python \
      py-pip \
    && rm -f /var/cache/apk/* \
    && pip install -Iv awscli==${VERSION} \
    && apk del --purge py-pip py-setuptools \
    && adduser -D user

USER user
WORKDIR /home/user

ENTRYPOINT ["aws"]
CMD ["help"]
