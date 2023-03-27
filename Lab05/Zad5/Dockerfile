# Pierwszy etap
FROM ubuntu:latest AS builder
LABEL stage=builder

RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

COPY ./app ./

RUN npm install

RUN npm run build


# Drugi etap
FROM nginx:latest

COPY --from=builder /app/build /usr/share/nginx/html

# RUN adduser --system --no-create-home --group www

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

# RUN nginx -g 'daemon off;'
