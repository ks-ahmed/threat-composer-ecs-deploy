FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

RUN yarn build

FROM nginx:alpine

RUN addgroup -S devgroup && adduser -S user1 -G devgroup

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/build /usr/share/nginx/html

RUN chown -R user1:devgroup /usr/share/nginx/html

USER user1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
