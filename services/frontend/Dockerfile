FROM alpine:3.11 AS development

ARG bash_version=5.0.11-r1
ARG git_version=2.24.2-r1
ARG jq_version=1.6-r0
ARG nodejs_version=12.15.0-r1
ARG npm_version=12.15.0-r1
ARG shellcheck=0.7.0-r1
ARG make_version=4.2.1-r2

RUN apk --update --no-cache add \
    bash=${bash_version} \
    git=${git_version} \
    jq=${jq_version} \
    nodejs=${nodejs_version} \
    npm=${npm_version} \
    shellcheck=${shellcheck}

RUN npm install -g npm@6.13.4 && \
    npm install -g @vue/cli@4.1.2

FROM development AS build

COPY . .
RUN npm install
RUN npm run build

FROM nginx:alpine AS prod

ARG BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
ARG VCS_REF="$(git rev-parse HEAD)"

LABEL maintainer="Mathmagicians" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="Mathmagicians" \
      org.label-schema.name="Kumori" \
      org.label-schema.license="MIT" \
      org.label-schema.description="Kumori Project" \
      org.label-schema.vcs-url="https://github.com/Mathmagicians/kumori" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.url="https://github.com/Mathmagicians/kumori" \
      org.label-schema.usage="https://github.com/Mathmagicians/kumori/blob/master/README.md"

COPY --from=build /dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 -R /var/log/nginx
