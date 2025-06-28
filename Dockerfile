FROM mcr.microsoft.com/playwright:v1.45.0-jammy

# Cài Chromium nếu chưa có
RUN apt-get update && apt-get install -y wget gnupg unzip

EXPOSE 9222

CMD ["chromium", \
  "--no-sandbox", \
  "--disable-dev-shm-usage", \
  "--disable-gpu", \
  "--headless=new", \
  "--remote-debugging-port=9222", \
  "--remote-debugging-address=0.0.0.0", \
  "--user-data-dir=/tmp/chrome"]
