FROM node:alpine

WORKDIR /opt/app

COPY ./package.json ./

RUN npm install --production --silent

COPY . .

EXPOSE 4000

CMD node index.js