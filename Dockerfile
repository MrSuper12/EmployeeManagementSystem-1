FROM node:14-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install --silent

COPY . .

RUN npm run build

FROM node:14-alpine

ENV NODE_ENV=production
ENV PORT=3000

WORKDIR /app

COPY package*.json ./
RUN nom install --production --silent

EXPOSE 3000

CMD["npm","start"]