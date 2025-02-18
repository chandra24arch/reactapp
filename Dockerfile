# Step 1: Use the official Node.js image to build the app
FROM node:16 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve the app using Nginx (or any other web server)
FROM nginx:alpine

# Copy the built app from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 3000

# Start the Nginx server to serve the React app
CMD ["nginx", "-g", "daemon off;"]
