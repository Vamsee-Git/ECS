# Stage 1: Build stage
FROM node:16 AS builder
 
# Set the working directory inside the container
WORKDIR /usr/src/app
 
# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./
 
# Install the dependencies
RUN npm install
 
# Copy the rest of the application code
COPY . .
 
# Stage 2: Runtime stage
FROM node:16-slim
 
# Set the working directory inside the container
WORKDIR /usr/src/app
 
# Copy only the necessary files from the build stage
COPY --from=builder /usr/src/app /usr/src/app
 
# Install only production dependencies (optional, if you want to optimize further)
RUN npm install --only=production
 
# Expose the port your app will run on
EXPOSE 3000
 
# Define the command to run your app
CMD ["node", "patient-service.js"]
