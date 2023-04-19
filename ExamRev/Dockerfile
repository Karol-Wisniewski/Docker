# First stage of build

FROM alpine:latest AS build

ARG GIT_REPO

WORKDIR /usr/app

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git curl nodejs npm

RUN git clone ${GIT_REPO} .

RUN npm install

RUN npm run build

# Second stage of build

FROM nginx:latest

COPY --from=build /usr/app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
