FROM alpine:latest

RUN apk add --no-cache ca-certificates curl unzip \
    && mkdir -p /usr/local/bin/xray /etc/xray \
    && curl -fsSL -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v26.11.9/Xray-linux-64.zip \
    && unzip -o /tmp/xray.zip -d /usr/local/bin/xray \
    && chmod +x /usr/local/bin/xray/xray \
    && rm -f /tmp/xray.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV TZ=Asia/Shanghai

CMD ["/entrypoint.sh"]
