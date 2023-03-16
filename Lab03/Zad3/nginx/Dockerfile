FROM nginx:latest

RUN mkdir /etc/nginx/ssl

# instalacja openssl
RUN apt-get update && \
    apt-get install -y openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# tworzenie certyfikatu
RUN openssl req \
    -newkey rsa:2048 -nodes -keyout /etc/nginx/ssl/key.pem \
    -x509 -days 365 -out /etc/nginx/ssl/certificate.pem \
    -subj "/CN=localhost"

RUN chown nginx:nginx /var/cache/nginx

RUN rm /etc/nginx/conf.d/default.conf
COPY ./default.conf /etc/nginx/conf.d
# COPY certificate.pem /etc/nginx/ssl/certificate.pem
# COPY key.pem /etc/nginx/ssl/key.pem

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]