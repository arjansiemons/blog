# Blog Deployment Architecture

This document explains how the blog is deployed using a GitOps approach.

## Overview

The deployment architecture follows a GitOps pattern with separation of concerns:

1. **Blog Content Repository**: Contains blog content, Hugo configuration, and Dockerfile
2. **Homelab Repository**: Contains Kubernetes manifests and infrastructure configuration

## How It Works

### Blog Repository (this repo)

When new content is pushed to the main branch:

1. A GitHub Action builds the Hugo site
2. The action builds a Docker image with Nginx and pushes it to GitHub Container Registry
3. The image is tagged with both `latest` and the commit SHA

### Homelab Repository

The homelab repository:

1. Uses FluxCD to detect new container images in GitHub Container Registry
2. Automatically updates the deployment with the new image
3. Applies the changes to the Kubernetes cluster

## CI/CD Pipeline

The GitHub Actions workflow in this repository:

- Builds the Hugo site
- Packages it with Nginx in a multi-stage Docker build
- Pushes the image to GitHub Container Registry (ghcr.io)

## Configuration Files

- `Dockerfile`: Multi-stage build that combines Hugo and Nginx
- `.github/workflows/deploy.yml`: GitHub Actions workflow for building and publishing

## Local Development

Normal Hugo development is unaffected by this setup:

```bash
# Start local Hugo server
hugo server -D
```

## Docker Image

The Docker image uses a multi-stage build:

1. First stage uses Hugo to build the static site
2. Second stage uses Nginx to serve the content

This results in a small, efficient container that serves the site using Nginx's high-performance web server.
