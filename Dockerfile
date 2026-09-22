# Use a base image that already includes Chromium and all required dependencies
FROM node:18-bullseye-slim

# Install n8n and the Puppeteer community node globally
RUN npm install -g n8n n8n-nodes-puppeteer

# Tell Puppeteer to use the system Chromium (it will use the one from the base image)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Set the working directory for n8n
WORKDIR /home/node/.n8n

# Expose n8n's default port
EXPOSE 5678

# Start n8n
CMD ["n8n"]
