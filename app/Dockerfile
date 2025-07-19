FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build

# Use nginx and set up directories
FROM nginx:alpine

# Create non-root user
RUN addgroup -S devgroup && adduser -S user1 -G devgroup

# Clean default Nginx web content
RUN rm -rf /usr/share/nginx/html/*

# Copy built frontend
COPY --from=builder /app/build /usr/share/nginx/html

# Fix permissions
RUN chown -R user1:devgroup /usr/share/nginx/html && \
    mkdir -p /var/cache/nginx /var/run && \
    chown -R user1:devgroup /var/cache/nginx /var/run

# Replace default nginx.conf with a custom one
COPY nginx.conf /etc/nginx/nginx.conf

# Run as non-root user
USER user1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
