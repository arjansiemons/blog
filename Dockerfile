#####################################################################
#                            Build Stage                            #
#####################################################################
FROM hugomods/hugo:exts as builder

# Build site
WORKDIR /src
COPY . .

# Build Hugo site
RUN hugo --minify --enableGitInfo

# We use Nginx's default error handling, so no need to ensure 404.html exists

#####################################################################
#                            Final Stage                            #
#####################################################################
FROM nginx:alpine

# Add extra functionality
RUN apk add --no-cache curl ca-certificates

# We use K8s ConfigMap for Nginx configuration
# No need to copy a config file here

# Copy built site from builder stage
COPY --from=builder /src/public /usr/share/nginx/html

# Default command
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
