FROM node:17-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Copy the run_tests.sh script
COPY run_tests.sh .

# Make the script executable
RUN chmod +x run_tests.sh

# Build the React app
RUN npm run build

# Run unit tests
RUN npm run test

# Install and configure serve
RUN npm install -g serve

# Start the application
CMD ["serve", "-s", "build"]

# Expose port 3000
EXPOSE 3000


