# # Build stage
# FROM node:16.13.2 AS build

# WORKDIR /myapp

# COPY package*.json .

# RUN npm install --legacy-peer-deps

# COPY . .

# RUN npm run build

# # Run stage
# FROM nginx:alpine

# COPY --from=build /myapp/public/build /usr/share/nginx/html

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]

# CMD ["npm", "start"]

# FROM nginx:stable-alpine
# COPY --from=build /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]


 # Fetching the latest node image on apline linux
FROM node:alpine AS builder

# Declaring env
# ENV NODE_ENV production

# Setting up the work directory
WORKDIR /testapp/_work/docker-cicd/docker-cicd

# Installing dependencies
COPY ./package.json ./
RUN npm install

# Copying all the files in our project
COPY . .

# Building our application
RUN npm run build

# Fetching the latest nginx image
FROM nginx

# Copying built assets from builder
COPY --from=builder /testapp/_work/docker-cicd/docker-cicd/build /usr/share/nginx/html

# Copying our nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
