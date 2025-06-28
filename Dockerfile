FROM debian:bullseye-slim

# Cài dependency
RUN apt-get update && apt-get install -y \
  wget curl gnupg unzip fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 \
  libcups2 libdbus-1-3 libgdk-pixbuf2.0-0 libnspr4 libnss3 libx11-xcb1 libxcomposite1 \
  libxdamage1 libxrandr2 libxss1 libxtst6 libxshmfence1 xdg-utils \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Thêm repo Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*

# Expose port debug
EXPOSE 9222

# CMD ép Chrome lắng nghe toàn bộ IP, không sandbox
CMD ["google-chrome-stable", \
     "--no-sandbox", \
     "--disable-dev-shm-usage", \
     "--disable-gpu", \
     "--headless=new", \
     "--remote-debugging-address=0.0.0.0", \
     "--remote-debugging-port=9222", \
     "--user-data-dir=/tmp/chrome"]
