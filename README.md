# Hugo Blog

This repository contains a Hugo blog with a modern deployment setup.

## Architecture

The site uses a multi-stage build approach:
1. Hugo (build stage) - Compiles the site to static HTML/CSS/JS
2. Nginx (runtime) - Serves the static content efficiently with proper caching and compression

## Local Development

To run the site locally:

```bash
# Install Hugo if you don't have it
# https://gohugo.io/installation/

# Clone the repository with submodules
git clone --recursive https://github.com/arjansiemons/blog.git
cd blog

# Start the local development server
hugo server -D
```

## Docker Build

To build the Docker image locally:

```bash
docker build -t hugo-site:local .
docker run -p 8080:80 hugo-site:local
```

Then visit http://localhost:8080 in your browser.

## Deployment

This site is deployed to Kubernetes via GitHub Actions. The workflow:

1. Runs a test to verify the Hugo build works
2. Builds a Docker image and pushes to GitHub Container Registry
3. FluxCD handles the deployment in the infrastructure repository

For more details, see [DEPLOYMENT.md](DEPLOYMENT.md).

## Features

- **Multi-stage Docker build** - Optimized for production
- **Nginx Alpine** - Lightweight and secure
- **Default 404 handling** - Standard HTTP responses
- **Gzip compression** - Faster page loads
- **Security headers** - XSS protection, content-type protection
- **Cache control** - Efficient caching for static assets
- **Health checks** - Built-in container health monitoring
