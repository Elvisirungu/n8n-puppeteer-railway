# Use a standard Debian-based Node.js image (avoids the missing apk problem)
FROM node:18-bullseye

# Install Chromium and all required dependencies using apt-get
RUN apt-get update && apt-get install -y \
    chromium \
    libnss3 \
    libfreetype6 \
    libharfbuzz0b \
    ca-certificates \
    fonts-freefont-ttf \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Tell Puppeteer to use the system Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Install n8n and the Puppeteer community node globally
RUN npm install -g n8n n8n-nodes-puppeteer

# Set the working directory (this is where n8n looks for its data)
WORKDIR /home/node/.n8n

# Expose n8n's default port
EXPOSE 5678

# Start n8n
CMD ["n8n"]
