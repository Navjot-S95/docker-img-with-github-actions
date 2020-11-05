#build
FROM node:13.12.0-alpine as build
WORKDIR /my-app
ENV PATH /my-app/node_modules/.bin:$PATH
COPY . ./
RUN npm ci --silent && npm install react-scripts@3.4.1 -g --silent
RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /my-app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



