FROM alpine:latest

RUN apk upgrade --update --available && \
    apk add \
      ca-certificates \
      groff \
      less \
      python \
      py-pip \
    && rm -f /var/cache/apk/* \
    && pip install awscli \
    && adduser -D user

USER user
WORKDIR /home/user

ENTRYPOINT ["aws"]
CMD ["help"]
