FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  wget curl gnupg unzip ca-certificates fonts-liberation \
  libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libcups2 \
  libdbus-1-3 libgdk-pixbuf2.0-0 libnspr4 libnss3 libxcomposite1 \
  libxdamage1 libxrandr2 xdg-utils \
  --no-install-recommends

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
  > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y google-chrome-stable && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 9222

CMD ["google-chrome-stable", \
  "--no-sandbox", \
  "--disable-dev-shm-usage", \
  "--disable-gpu", \
  "--headless=new", \
  "--remote-debugging-port=9222", \
  "--remote-debugging-address=0.0.0.0", \
  "--user-data-dir=/tmp/chrome"]
