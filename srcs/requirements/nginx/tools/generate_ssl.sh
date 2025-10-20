#!/bin/sh

SSL_DIR="/etc/nginx/ssl"
mkdir -p $SSL_DIR

if [ ! -f "$SSL_DIR/server.crt" ]; then
    echo "🔑 Génération du certificat SSL..."
    openssl req -x509 -nodes -days 365 \
        -subj "/C=FR/ST=Lyon/L=Lyon/O=42/OU=Student/CN=localhost" \
        -addext "subjectAltName=DNS:localhost" \
        -newkey rsa:2048 \
        -keyout "$SSL_DIR/server.key" \
        -out "$SSL_DIR/server.crt"
else
    echo "✅ Certificat SSL déjà présent"
fi
