# syntax=docker/dockerfile:1

ARG NODE_VERSION=lts
ARG NGINX_VERSION=stable

################################################################################
# Set the base image
FROM node:${NODE_VERSION}-alpine as base
# Set the working directory
WORKDIR /usr/src/app

################################################################################
# Create a stage for installing dependecies
FROM base as deps
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --include=dev

################################################################################
# Create a stage for running the application in development mode
FROM deps as development
# Copy the source code
COPY . .
# Expose the port
EXPOSE 3000
# Run the application
CMD ["npm", "run", "dev"]

################################################################################
# Create a stage for building the application
FROM deps as build
# Copy the source code
COPY . .
# Build the application
RUN npm run build

################################################################################
# Create a stage for running the application in production mode
FROM nginx:${NGINX_VERSION}-alpine as production
# Copy the built application
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
# Copy the nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose the port
EXPOSE 80
# Run the application
CMD ["nginx", "-g", "daemon off;"]