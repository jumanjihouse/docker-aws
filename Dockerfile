FROM alpine:latest

# Which version of awscli to install.
ENV VERSION 1.7.34

RUN apk upgrade --update --available && \
    apk add \
      ca-certificates \
      groff \
      less \
      python \
      py-pip \
    && rm -f /var/cache/apk/* \
    && pip install -Iv awscli==${VERSION} \
    && adduser -D user

USER user
WORKDIR /home/user

ENTRYPOINT ["aws"]
CMD ["help"]
