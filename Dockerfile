# Use an official Node.js runtime as the build environment
FROM node:18-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React app for production
RUN npm run build

# Use an official Nginx runtime as the web server
FROM nginx:alpine

# Copy the built app from the previous stage to the Nginx web root
COPY --from=build /app/build /usr/share/nginx/html

# Set the working directory in the container
WORKDIR /usr/share/nginx/html

# Remove the default Nginx configuration
RUN rm -rf /etc/nginx/conf.d/*

# Create a custom Nginx configuration file
COPY .config/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to the outside world
EXPOSE 5000

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
