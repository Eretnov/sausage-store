FROM node:16.20.0-alpine3.18 AS builder
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY . .
RUN npm install \
    && npm run build

FROM nginxproxy/nginx-proxy:1.7-alpine
ARG VERSION=${VERSION}
WORKDIR /app
COPY ./nginx.tmpl /app/nginx.tmpl
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html
EXPOSE 80 
