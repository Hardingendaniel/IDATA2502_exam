FROM node:17-alpine

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React app
RUN npm run build

# Install and configure serve
RUN npm install
CMD ["npm", "start"]

# Expose port 3000
EXPOSE 3000


