# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Copy the static files to the Nginx HTML directory
COPY app/main.html /usr/share/nginx/html/index.html