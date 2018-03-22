FROM nginx:alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs

COPY ./ /usr/share/nginx/html
RUN sed -i 's/vue.js/vue.min.js/' /usr/share/nginx/html/index.html
