FROM node:alpine
ENV CHROME_BIN="/usr/bin/chromium-browser" \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"
WORKDIR /app
RUN apk add --no-cache bash udev ttf-freefont chromium coreutils
COPY package.json /app
RUN npm i
COPY codecept.conf.js /app/
COPY docker/entrypoint.sh /app/
COPY app.js /app/
ENTRYPOINT ["/app/entrypoint.sh"]