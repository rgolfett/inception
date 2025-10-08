#!/bin/sh


DOMAIN="rgolfett.42.fr"
COUNTRY="FR"
STATE="Paris"
LOCALITY="Paris"
ORG="MyOrg"
VALID_DAYS_CA=3650
VALID_DAYS_CERT=365

SSL_DIR="./srcs/requirements/nginx/conf/ssl"


if [ -f "$SSL_DIR/fullchain.crt" ]; then
    echo "🔑 SSL already exists"
    exit 0
fi

mkdir -p "$SSL_DIR"
cd "$SSL_DIR"

echo "🔑 Generating CA..."

cat > ca.cnf <<EOF
[ req ]
prompt             = no
distinguished_name = dn
x509_extensions    = v3_ca

[ dn ]
C  = ${COUNTRY}
ST = ${STATE}
L  = ${LOCALITY}
O  = ${ORG}
CN = MyLocalCA

[ v3_ca ]
basicConstraints   = critical,CA:TRUE
keyUsage           = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
EOF

openssl genrsa -out nginxCA.key 2048
openssl req -x509 -days "${VALID_DAYS_CA}" -key nginxCA.key \
            -out nginxCA.crt -config ca.cnf


cat > server.cnf <<EOF
[ req ]
prompt             = no
distinguished_name = dn
req_extensions     = req_ext
default_md         = sha256
default_bits       = 2048

[ dn ]
C  = ${COUNTRY}
ST = Local
L  = Local
O  = ${ORG}
CN = ${DOMAIN}

[ req_ext ]
subjectAltName     = @alt_names
extendedKeyUsage   = serverAuth
keyUsage           = digitalSignature,keyEncipherment

[ alt_names ]
DNS.1 = ${DOMAIN}
EOF

openssl genrsa -out nginx.key 2048
openssl req -new -key nginx.key -out nginx.csr -config server.cnf
openssl x509 -req -days "${VALID_DAYS_CERT}" -in nginx.csr \
        -CA nginxCA.crt -CAkey nginxCA.key -CAcreateserial \
        -out nginx.crt -extfile server.cnf -extensions req_ext

cat nginx.crt nginxCA.crt > fullchain.crt



