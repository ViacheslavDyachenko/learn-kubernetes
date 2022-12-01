FROM node:16-alpine as builder
COPY package.json ./
RUN npm install
COPY ./public /public
COPY ./src /src
RUN npm run build

FROM nginx:1.23.2-alpine
COPY ./conf.d/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /build /usr/share/nginx/html
EXPOSE 8899