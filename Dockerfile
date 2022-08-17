FROM node:16-alpine as builder 
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 

FROM nginx
# telling elastic beanstalk which ports are exposed
EXPOSE 80
# COPY [from], [folder_of_intrest], directory specified in nginx doc
COPY --from=builder /app/build /usr/share/nginx/html