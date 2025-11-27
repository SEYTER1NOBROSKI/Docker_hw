FROM alpine:latest

RUN apk update && apk add netcat-openbsd

WORKDIR /scripts

CMD ["tail", "-f", "/dev/null"]