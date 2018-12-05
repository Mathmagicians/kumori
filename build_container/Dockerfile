FROM alpine:latest

ADD https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 /

RUN apk update && apk upgrade && apk add bash nodejs npm make zip curl

RUN mv /jq-linux64 /usr/bin/jq && \
    chmod 755 /usr/bin/jq
