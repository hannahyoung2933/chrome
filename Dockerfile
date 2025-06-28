FROM browserless/chrome:latest

EXPOSE 3000

# Tự động khởi động khi container chạy (đã có sẵn trong image)
CMD ["node", "build/index.js"]
