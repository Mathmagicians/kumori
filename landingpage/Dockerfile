FROM nginx:alpine
COPY ./ /usr/share/nginx/html
RUN sed -i 's/vue.js/vue.min.js/' /usr/share/nginx/html/index.html
