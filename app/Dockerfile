FROM node:18 AS builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build

FROM nginx:alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

RUN chown -R appuser:appgroup /usr/share/nginx/html

USER appuser

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
