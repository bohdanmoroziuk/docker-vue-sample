# syntax=docker/dockerfile:1

ARG NODE_VERSION=lts
ARG NGINX_VERSION=stable

################################################################################
FROM node:${NODE_VERSION}-alpine as base
WORKDIR /usr/src/app

################################################################################
FROM base as deps
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --include=dev

################################################################################
FROM deps as development
COPY . .
EXPOSE 3000
CMD npm run dev

################################################################################
FROM deps as build
COPY . .
RUN npm run build

################################################################################
FROM nginx:${NGINX_VERSION}-alpine as production
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]