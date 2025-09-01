
---

## 📄 2. `docs/EVALUATION.md`

```md
# 🧪 Plan de Soutenance — ft_transcendence

## Phase 0 — Mandatory
- Lancer le projet avec `make up`
- Vérifier que le site est accessible en **HTTPS** (reverse-proxy OK)
- Vérifier qu’il n’y a pas d’erreurs console dans Firefox
- Accéder au **jeu Pong local** (2 joueurs sur un clavier)
- Créer un **tournoi offline** avec des alias → affichage du bracket + ordre des matchs

## Phase 1 — Backend & DB
- Vérifier l’API Fastify en `/health`
- Vérifier migrations + seeds SQLite
- Vérifier que les scores de tournoi sont persistés

## Phase 2 — User Management
- Inscription / connexion (auth standard)
- Profils, avatars par défaut
- Ajout d’amis + statut en ligne
- Historique de matchs

## Phase 3 — JWT + 2FA
- Login avec JWT (access/refresh)
- Activation 2FA (QR code + TOTP)
- Test d’une connexion protégée

## Phase 4 — Remote Pong
- Deux navigateurs différents jouent en ligne
- Gestion déco/reconnexion
- Latence gérée (UX fluide)

## Phase 5 — Live Chat
- Envoyer un DM
- Bloquer un utilisateur
- Inviter via chat à jouer
- Notification de tournoi
- Accéder au profil depuis le chat

## Phase 6 — Remote Auth Google
- Connexion avec Google
- Vérifier liaison du compte

## Phase 7 — AI Opponent
- Jouer contre l’IA (1 Hz, input clavier simulé)
- L’IA peut gagner

## Phase 8 — Minors
- Options de personnalisation du jeu
- Dashboard stats (users + matches)
- Monitoring Prometheus/Grafana
- Responsive / multi devices
- Compatibilité navigateur supplémentaire
- Multi-langues (≥3)
- Accessibilité (visually impaired)
- SSR minimal
- GDPR options (export / anonymisation / delete)
