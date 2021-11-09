FROM node:16

WORKDIR /app

COPY package.json ./

RUN npm install -g http-server

RUN npm install

RUN npm run build

CMD [ "http-server", "dist" ]