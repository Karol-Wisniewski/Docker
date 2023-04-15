FROM nginx

COPY ./default.conf /etc/nginx/conf.d/default.conf

RUN apt update

RUN apt install curl -y

RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && apt-get install -y nodejs

WORKDIR /app

COPY package*.json .

COPY app.js .

RUN npm i

CMD ["node", "app.js"]