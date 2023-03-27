# Pierwszy etap
FROM ubuntu:latest AS builder
LABEL stage=builder

# Aktualizacja pakietów i instalacja zależności
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Praca w katalogu aplikacji
WORKDIR /app

# Skopiowanie plików package.json oraz package-lock.json
COPY ./app ./

RUN npm install -g npm@latest

RUN npm install --save-dev @babel/preset-react  

# Instalacja zależności
RUN npm install

# Skopiowanie reszty plików
COPY . .

# Budowa aplikacji
RUN npm run build


# Drugi etap
FROM nginx:latest

# Kopiowanie plików z pierwszego etapu
COPY --from=builder /app/build /usr/share/nginx/html

# Kopiowanie pliku konfiguracyjnego
COPY nginx.conf /etc/nginx/nginx.conf

# Uruchomienie serwera nginx
CMD ["nginx", "-g", "daemon off;"]
