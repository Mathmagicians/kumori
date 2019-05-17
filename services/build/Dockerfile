FROM alpine:latest

ADD https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 /
ADD https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz /

RUN apk update && apk upgrade && apk add bash openjdk8 nodejs git npm make zip curl xz

RUN mv /jq-linux64 /usr/bin/jq && \
    chmod 755 /usr/bin/jq && \
    tar --xz -xvf shellcheck-stable.linux.x86_64.tar.xz && \
    cp shellcheck-stable/shellcheck /usr/bin/ && \
    npm install -g npm && \
    npm install -g @vue/cli
