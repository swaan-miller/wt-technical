FROM node:latest

WORKDIR /app
CMD npm install && npm run dev
