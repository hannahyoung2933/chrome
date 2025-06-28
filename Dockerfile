FROM debian:bullseye-slim

# Cài dependencies cần thiết
RUN apt-get update && apt-get install -y \
  wget curl gnupg unzip ca-certificates fonts-liberation \
  libasound2 libatk-bridge2.0-0 libatk1.0-0 \
  libcups2 libdbus-1-3 libgdk-pixbuf2.0-0 libnspr4 libnss3 \
  libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 \
  libxss1 libxtst6 libxshmfence1 xdg-utils gnupg2 --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Add Google Chrome key manually (APT no longer allows wget | apt-key)
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub -o /etc/apt/keyrings/google-linux-signing-key.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list

# Cài Google Chrome stable
RUN apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*

# Expose remote debugging port
EXPOSE 9222

# Start headless Chrome with websocket enabled for Puppeteer
CMD ["google-chrome-stable", \
     "--no-sandbox", \
     "--disable-dev-shm-usage", \
     "--disable-gpu", \
     "--headless=new", \
     "--remote-debugging-address=0.0.0.0", \
     "--remote-debugging-port=9222", \
     "--user-data-dir=/tmp/chrome"]
