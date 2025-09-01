Objectif points = **7 majeurs (70 pts) + 11 mineurs (55 pts) = 125 pts**.
Rappel : les bonus ne sont évalués que si le **mandatory est parfait** (zéro erreur) .

---

# 🗺️ Roadmap ft\_transcendence (v16.1) — 125 pts sans rework

## 🎯 Cibles de modules (choix optimisés)

### Majors (7 × 10 = 70 pts)

1. **Web – Backend Fastify/Node.js** (Framework)
2. **User Management – Standard auth + profils**
3. **Cybersecurity – JWT + 2FA**
4. **Gameplay – Remote players** (WS temps réel)
5. **Gameplay – Live Chat** (DM, block, invite, notifs)
6. **User Management – Remote authentication (Google)**
7. **AI-Algo – AI Opponent** (1 Hz, input clavier simulé)

> On **évite** les majors lourds en rework (microservices, ELK, graphics 3D, server-side pong, multi >2, second jeu).

### Minors (11 × 5 = 55 pts)

* **Web – Frontend toolkit (Tailwind)**
* **Web – Database (SQLite)** (si backend)
* **Gameplay – Game customization options** (power-ups/maps/options)
* **AI-Algo – User & game stats dashboards**
* **DevOps – Monitoring (Prometheus/Grafana)**
* **Accessibility – Support on all devices** (responsive + inputs)
* **Accessibility – Expanding browser compatibility** (un navigateur en plus)
* **Accessibility – Multiple languages** (≥3)
* **Accessibility – Visually impaired features** (ARIA/contrast/focus)
* **Accessibility – SSR integration**
* **Cybersecurity – GDPR options** (anonymisation + delete)

---

## 🧱 Invariants d’architecture (anti-rework)

* **SPA TypeScript** (Firefox latest), **Docker** “one command”, **HTTPS/WSS**, **validation inputs** et **XSS/SQLi** dès le début (obligatoire mandatory) .
* Schéma DB dès J0 : `users, sessions/refresh, 2fa_secrets, friends, matches, match_players, messages, locales, privacy_requests, stats_aggregates`.
* Back **Fastify** modulaire (`modules/auth, users, game, chat`) ; Front **Tailwind** ; **SQLite** via `better-sqlite3`.
* **Reverse-proxy** Nginx (TLS dev), routes : `/` (SPA), `/api` (Fastify), `/ws` (WS → WSS).
* **Types partagés** (`backend/src/shared`) importés côté front pour éviter les divergences.

---

## 📅 Planning par étapes

### Phase 0 — Boot & Mandatory (💯 fiabilité) — *2 à 3 jours*

**But** : Base propre, **Pong local** + **tournoi offline** + **Docker up unique**.
**Structure à créer/utiliser :**

* `infra/` : `docker-compose.yml`, `reverse-proxy/` (certs dev), `database/vol/`
* `frontend/` : SPA TS + **Tailwind** (minor)
* `backend/` : **Fastify** (major), `/health`, ping route
* `frontend/pages/game/PlayLocal.ts` + `tournament` local (alias saisis en début de tournoi)
  **Critères d’acceptation :**
* `make up` → site en **HTTPS** (wss prêt), **SPA** compatible Firefox, **aucune erreur console**
* Jeu **Pong local** (mêmes vitesses paddles), tournoi basique + matchmaking affiché
* **Validation inputs** côté front, anti-XSS/SQLi en place, mots de passe **hashés** (si DB déjà branchée)
  **Points safe après phase** : Mandatory validable (ouvre la porte aux bonus) + 2 minors (Tailwind, SQLite préparée).

---

### Phase 1 — Web Backend + DB (🎯 base de points) — *2 jours*

**But** : Valider **Web/Framework (major)** + **DB/SQLite (minor)** sans retoucher le jeu.

* `backend/modules/pong` : endpoints **tournoi offline persisté** (scores, bracket simple)
* `backend/db` : migrations + seeds (users de démo), **password hashing**
* `frontend` : `api/*` + `store` basique (tournoi)
  **Critères** :
* CRUD minimal users/tournaments/scores (protégé contre inputs foireux)

---

### Phase 2 — User Management standard (👤 major) — *2 jours*

**But** : **Register/Login**, profils, avatar par défaut, amis, **stats de base**

* `backend/modules/auth, users, friends, stats` ; `frontend/pages/auth/*`, `Profile.ts`
  **Critères** :
* Flux d’inscription/connexion **sécurisé** ; profils éditables ; amis + statut en ligne ; **match history** (1v1) visible

---

### Phase 3 — JWT + 2FA (🔐 major) — *1,5 jour*

**But** : **JWT access+refresh**, **TOTP 2FA** (QR), rate-limit login

* `auth-jwt.ts`, `totp.service.ts`, `BackupCodes` côté front
  **Critères** :
* Login → si 2FA activé, étape TOTP ; cookies sécurisés/headers stricts ; rate-limit sur `/auth/login`

---

### Phase 4 — Remote Players (🌐 major) — *2 jours*

**But** : **Pong en ligne** à 2 joueurs, gestion latence/déco

* `backend/modules/game`: `game.gateway.ts`, `rooms.service.ts`, `sync.service.ts`
* `frontend/pages/game/PlayRemote.ts`, `websocket/game.socket.ts`
  **Critères** :
* Matchmaking simple (invite/lien), **reconnexion** et reprise (“best UX possible”)

---

### Phase 5 — Live Chat (💬 major) — *1,5 jour*

**But** : DMs, **block**, **invite to play**, **notifs tournoi**, accès profils via chat

* `backend/modules/chat` (WS), `moderation.service.ts` ; Front `Chat.ts`, `ChatPanel.ts`
  **Critères** :
* DM temps réel, **block** effectif, invite → ouvre PlayRemote, notifs “next match”

---

### Phase 6 — Remote Auth Google (🔑 major) — *1 jour*

**But** : **Google Sign-In** (flow complet)

* `backend/modules/remote-auth/google*` ; Front `GoogleSignIn.ts`
  **Critères** :
* Connexion via Google → compte lié, sécurisé, conforme aux bonnes pratiques.

---

### Phase 7 — AI Opponent (🤖 major) — *2 jours*

**But** : IA “humaine” : **rafraîchit sa vue 1 Hz** + **simule des key up/down** ; vitesses égales joueurs/IA

* `backend/modules/ai` + adaptateurs input côté moteur
  **Critères** :
* L’IA **peut gagner** parfois ; fonctionne aussi si **customizations** activées (si prises)

---

### Phase 8 — Minors faciles (📈 11 mineurs) — *3 à 4 jours au total*

1. **Game customization options** (menus options & règles) — *0,5 j*
2. **Stats dashboards** (UI charts + endpoints agrégés) — *0,5 j*
3. **Monitoring Prometheus/Grafana** (compose annexe) — *0,5 j*
4. **All devices** (responsive + inputs touch/clavier) — *0,5 j*
5. **Extra browser** (tests + fixes) — *0,25 j*
6. **i18n ≥ 3 langues** (FR/EN/ES) — *0,5 j*
7. **A11y (visually impaired)** (ARIA/contrast/focus/skip-links) — *0,5 j*
8. **SSR integration** (profil prod simple pour 2–3 routes) — *0,5–0,75 j*
9. **GDPR options** (export/anonymize/delete + PrivacyCenter) — *0,5–0,75 j*
10. **Frontend toolkit (Tailwind)** — **déjà fait** (phase 0)
11. **Database (SQLite)** — **déjà fait** (phase 1)

> Ces mineurs sont **orthogonaux** aux features centrales → très peu de rework. Les 2 derniers sont déjà gagnés.

---

## 🧪 Soutenance & Qualité (en continu)

* **EVALUATION.md** : scénario pas-à-pas (build → up → migrate → seed → démo Pong local → tournoi → auth → 2FA → remote → chat → Google → IA → mineurs).
* **Scripts** : `scripts/database/migrate.sh`, `seed.sh`, `reset.sh`, `demo/demo.sh`.
* **Tests smoke** : `/health`, `/auth/login`, `/users/me`, WS connect/disconnect.

---

## 📦 Répartition structure par phase (pour éviter de toucher deux fois)

* **Phase 0–1** : `infra/*`, `frontend/*` (SPA+Tailwind), `backend/{app,db,modules/pong}`, `shared/*`.
* **Phase 2–3** : `backend/modules/{users,auth}`, `middlewares/*`, `frontend/pages/auth/*`, `Profile.ts`.
* **Phase 4–5** : `backend/modules/{game,chat}`, `frontend/pages/game/PlayRemote.ts`, `Chat.ts`.
* **Phase 6** : `backend/modules/remote-auth`, `frontend/components/auth/GoogleSignIn.ts`.
* **Phase 7** : `backend/modules/ai`, `frontend/game/ai-client-adapter.ts`.
* **Phase 8** : dossiers mineurs dédiés (customization, dashboards, monitoring, a11y, i18n, SSR, GDPR) **sans toucher** à la base.

---

## 🧭 Règles clés du sujet à respecter (pour éviter les recalifs)

* **SPA TS**, **Firefox latest**, **Docker “one command”**, **HTTPS/WSS**, **validation inputs**, **XSS/SQLi**, **hash MDP**, **.env ignoré** .
* **Remote players UX solide** (déco/lag gérés), **tournoi clair** (matchmaking + ordre des matchs) .
* **IA** : 1 Hz, simulation clavier, **peut gagner** ; mêmes vitesses que joueurs .

---

## ✅ Bilan points & ordre optimal

* Après **Phase 0–1** : Mandatory ok + 2 minors (10 pts).
* **Phase 2–7** : +7 majors (70 pts) → **80 pts** cumulé bonus.
* **Phase 8** : +9 mineurs restants (45 pts) → **125 pts**.

Cet ordre **maximise la réutilisation** (auth/JWT/2FA, sockets, stores front, schéma DB) et **évite les gros modules structurants** (microservices, ELK, 3D, server-side pong) qui forcent souvent des refontes.

Si tu veux, je te fournis **EVALUATION.md prêt-à-lire** et le **squelette de migrations/seed** pour verrouiller la Phase 0–1 dès maintenant.
