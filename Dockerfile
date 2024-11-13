# Stage 1: Build the Hugo site
FROM klakegg/hugo:latest AS builder
WORKDIR /src

# Copy Hugo content and config files to the image
COPY . /src

# Run Hugo to generate the static site
RUN hugo --minify

# Stage 2: Package the site with NGINX
FROM nginx:alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80

