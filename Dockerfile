FROM alpine:3.4

# Which version of awscli to install.
# If you change this, you must also change Makefile and circle.yml.
ENV VERSION 1.10.38

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
