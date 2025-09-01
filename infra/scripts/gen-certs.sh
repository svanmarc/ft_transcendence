#!/usr/bin/env bash
set -euo pipefail

# Compat: si BASH_SOURCE n'existe pas (sh), on retombe sur $0
SCRIPT_PATH="${BASH_SOURCE[0]:-$0}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
CERT_DIR="${SCRIPT_DIR}/../reverse-proxy/certs"
CRT="${CERT_DIR}/localhost.crt"
KEY="${CERT_DIR}/localhost.key"
CNF="${CERT_DIR}/openssl.cnf"

mkdir -p "${CERT_DIR}"

# # Petit check openssl
# if ! command -v openssl >/dev/null 2>&1; then
#   echo "❌ openssl introuvable. Installe-le puis relance: make certs"
#   exit 1
# fi

cat > "${CNF}" <<'EOF'
[req]
default_bits       = 2048
prompt             = no
default_md         = sha256
req_extensions     = req_ext
distinguished_name = dn

[dn]
C  = FR
ST = Occitanie
L  = Perpignan
O  = ft_transcendence
OU = Dev
CN = localhost

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
IP.1  = 127.0.0.1
IP.2  = ::1
EOF

echo "🔐 Generating self-signed cert in: ${CERT_DIR}"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "${KEY}" -out "${CRT}" -config "${CNF}"

echo "✅ Cert generated:"
echo "   - ${CRT}"
echo "   - ${KEY}"
