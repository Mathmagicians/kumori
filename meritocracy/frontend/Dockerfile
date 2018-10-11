FROM nginx:alpine

ARG TARGET='Linux'

COPY nginx.conf /etc/nginx/nginx.conf
RUN if [ "${TARGET}" != "Darwin" ]; then sed -i 's/docker\.for\.mac\.localhost/swagger/' /etc/nginx/nginx.conf ; fi
COPY dist /usr/share/nginx/html
