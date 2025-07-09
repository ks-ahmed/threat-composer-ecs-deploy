FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --legacy-peer-deps

COPY . .

FROM node:18 

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 8080
CMD [ "npm", "start" ]