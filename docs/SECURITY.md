# 🔐 Security — ft_transcendence

## HTTPS / WSS
- Certificat autosigné en dev
- Redirection HTTP → HTTPS

## CSP (Content Security Policy)
- Interdire inline scripts
- Limiter les sources externes

## XSS / SQLi
- Validation des inputs (front et back)
- Utiliser des requêtes préparées (SQLite)

## Cookies & Headers
- Cookies sécurisés (HttpOnly, Secure, SameSite)
- Headers HTTP (Helmet ou équivalent minimal)

## JWT & 2FA (prévu Phase 3)
- Access & refresh tokens
- Vérification TOTP via Google Authenticator
