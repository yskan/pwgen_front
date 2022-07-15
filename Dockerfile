FROM node:lts-alpine

ADD . /app

WORKDIR /app

RUN yarn install

EXPOSE 8080

