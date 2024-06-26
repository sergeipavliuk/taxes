FROM node:18-alpine as build-deps

WORKDIR /usr/src/app
COPY . ./

RUN yarn
RUN yarn build

FROM nginx:1.12-alpine
COPY --from=build-deps /usr/src/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
