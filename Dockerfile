FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
  wget curl gnupg2 ca-certificates fonts-liberation \
  libasound2 libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 \
  libgdk-pixbuf2.0-0 libnspr4 libnss3 libx11-xcb1 libxcomposite1 \
  libxdamage1 libxrandr2 libxss1 libxtst6 libxshmfence1 xdg-utils \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Add Google Chrome key and repo
RUN mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg && \
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
  > /etc/apt/sources.list.d/google-chrome.list

# Install Google Chrome
RUN apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*

# Expose DevTools port
EXPOSE 9222

# Start Chrome in headless mode
CMD ["google-chrome-stable", \
     "--no-sandbox", \
     "--disable-dev-shm-usage", \
     "--disable-gpu", \
     "--headless=new", \
     "--remote-debugging-address=0.0.0.0", \
     "--remote-debugging-port=9222", \
     "--user-data-dir=/tmp/chrome"]
