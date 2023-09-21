# Use an official Nginx runtime as a parent image
FROM nginx:alpine

# Set the working directory in the container
WORKDIR /usr/share/nginx/html

# Remove the default Nginx configuration
RUN rm -rf /etc/nginx/conf.d/*

# Copy the build output from the React app to the Nginx server root
COPY build/ .

# Create a custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to the outside world
EXPOSE 5000

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
