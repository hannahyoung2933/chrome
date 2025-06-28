FROM ubuntu:22.04

RUN apt-get update && apt-get install -y chromium-browser

EXPOSE 9222

CMD ["chromium-browser", \
  "--no-sandbox", \
  "--disable-dev-shm-usage", \
  "--disable-gpu", \
  "--headless=new", \
  "--remote-debugging-port=9222", \
  "--remote-debugging-address=0.0.0.0", \
  "--user-data-dir=/tmp/chrome"]
