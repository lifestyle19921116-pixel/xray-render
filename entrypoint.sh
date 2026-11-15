#!/bin/sh
set -e
: "${PORT:?missing PORT}"
: "${UUID:?missing UUID}"
: "${WS_PATH:?missing WS_PATH}"
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "inbounds": [{
    "port": ${PORT},
    "listen": "0.0.0.0",
    "protocol": "vless",
    "settings": {"clients": [{"id": "${UUID}"}], "decryption": "none"},
    "streamSettings": {"network": "ws", "wsSettings": {"path": "${WS_PATH}"}}
  }],
  "outbounds": [{"protocol": "freedom", "settings": {}}]
}
EOF
exec /usr/local/bin/xray/xray -config /etc/xray/config.json
