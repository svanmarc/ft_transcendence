ft_transcendence/
├─ README.md
├─ .gitignore
├─ .env.example                     # jamais committer .env réel
├─ Makefile                         # up / down / re / clean / fclean / logs / migrate / seed / demo
│
├─ docs/                            # Documentation (évaluable en soutenance)
│  ├─ ARCHITECTURE.md               # ADR + diagrammes (infra, modules, flux)
│  ├─ API.md                        # Contrats REST & WebSocket (req/rsp)
│  ├─ SECURITY.md                   # HTTPS, JWT, 2FA, XSS/SQLi, GDPR
│  ├─ MODULES.md                    # Tableau modules choisis → exigences
│  ├─ GAME_DESIGN.md                # Règles Pong, tournoi, UX, latence
│  └─ EVALUATION.md                 # Scénario démo + commandes
│
├─ infra/                           # Docker & orchestration
│  ├─ docker-compose.yml            # 1 seul up pour tout lancer (dev)
│  ├─ reverse-proxy/                # Nginx + SSL
│  │  ├─ Dockerfile
│  │  ├─ nginx.conf
│  │  └─ ssl/
│  │     ├─ dev.crt
│  │     └─ dev.key
│  ├─ database/                     # Module DB (SQLite obligatoire si backend)
│  │  ├─ vol/                       # fichier .sqlite (gitignored)
│  │  ├─ migrations/
│  │  │  ├─ 001_init.sql            # users, matches, messages, friends
│  │  │  └─ 002_extra.sql           # avatars, stats, 2fa_secrets
│  │  └─ seeds/
│  │     └─ dev.sql
│  └─ _optional/                    # Modules optionnels (si choisis plus tard)
│     ├─ docker-compose.prod.yml
│     ├─ microservices/             # DevOps Major
│     ├─ monitoring/                # DevOps Minor (Prometheus/Grafana)
│     ├─ waf-vault/                 # Cybersecurity Major (WAF + Vault)
│     └─ blockchain/                # Web Major (Avalanche, Solidity)
│
├─ backend/                         # Module Web Backend (Fastify/Node.js)
│  ├─ Dockerfile
│  ├─ package.json
│  ├─ tsconfig.json
│  └─ src/
│     ├─ app.ts                     # bootstrap Fastify (helmet, cors, rate-limit)
│     ├─ server.ts                  # start/stop + /health
│     ├─ routes.ts                  # registre des routes REST
│     ├─ config/
│     │  ├─ env.ts                  # validation env (.env → zod)
│     │  └─ security.ts             # CSP, cookies secure, HTTPS
│     ├─ db/
│     │  ├─ sqlite.ts                # connexion better-sqlite3
│     │  ├─ migrations.ts            # runner SQL
│     │  └─ queries.ts
│     ├─ middlewares/
│     │  ├─ validate.ts              # validation des inputs (zod)
│     │  ├─ auth-jwt.ts              # JWT + refresh
│     │  └─ rate-limit.ts            # anti brute-force login
│     ├─ modules/
│     │  ├─ pong/                    # Mandatory Game (Pong local + tournoi)
│     │  │  ├─ pong.controller.ts
│     │  │  └─ pong.service.ts
│     │  ├─ auth/                    # User mgmt + 2FA (Major)
│     │  │  ├─ auth.routes.ts
│     │  │  ├─ jwt.service.ts
│     │  │  ├─ totp.service.ts
│     │  │  ├─ backup-codes.service.ts
│     │  │  └─ password.service.ts
│     │  ├─ users/                   # User profiles, friends, stats
│     │  │  ├─ users.routes.ts
│     │  │  ├─ users.service.ts
│     │  │  ├─ friends.service.ts
│     │  │  └─ stats.service.ts
│     │  ├─ chat/                    # Major: Live Chat
│     │  │  ├─ chat.gateway.ts       # WebSocket (messages, présence, invites)
│     │  │  └─ chat.service.ts
│     │  └─ remote/                  # Major: Remote players
│     │     ├─ game.gateway.ts
│     │     ├─ rooms.service.ts
│     │     └─ matchmaking.service.ts
│     └─ shared/                     # Types/DTO communs avec le front
│        ├─ dto.ts
│        └─ ws.ts
│
├─ frontend/                         # SPA TypeScript + Tailwind (Minor Web)
│  ├─ Dockerfile
│  ├─ package.json
│  ├─ tsconfig.json
│  ├─ vite.config.ts
│  ├─ tailwind.config.js
│  ├─ public/
│  │  └─ index.html                  # entrypoint SPA
│  └─ src/
│     ├─ main.ts                     # bootstrap + router (History API)
│     ├─ app.css
│     ├─ router/
│     │  ├─ index.ts                 # routes: /, /login, /play, /chat, /profile
│     │  └─ guards.ts                # auth + 2FA guards
│     ├─ pages/
│     │  ├─ Home.ts
│     │  ├─ auth/
│     │  │  ├─ Login.ts
│     │  │  ├─ Register.ts
│     │  │  └─ Setup2FA.ts
│     │  ├─ game/
│     │  │  ├─ PlayLocal.ts          # Pong local (mandatory)
│     │  │  └─ PlayRemote.ts         # Remote players
│     │  ├─ Tournament.ts
│     │  ├─ Chat.ts
│     │  └─ Profile.ts
│     ├─ components/
│     │  ├─ layout/
│     │  │  ├─ Navbar.ts
│     │  │  └─ Footer.ts
│     │  ├─ auth/
│     │  │  ├─ QRCodeSetup.ts        # affichage QR TOTP
│     │  │  └─ TOTPInput.ts
│     │  ├─ game/
│     │  │  ├─ GameCanvas2D.ts       # moteur Pong 2D
│     │  │  ├─ ScoreBoard.ts
│     │  │  └─ MatchmakingPanel.ts
│     │  └─ chat/
│     │     ├─ ChatPanel.ts
│     │     ├─ UserList.ts
│     │     └─ MessageBubble.ts
│     ├─ game/
│     │  ├─ engine-2d.ts             # logique Pong
│     │  ├─ input.ts
│     │  └─ net-sync.ts              # sync temps réel
│     ├─ api/
│     │  ├─ client.ts                # fetch wrapper + refresh JWT
│     │  ├─ auth.api.ts
│     │  ├─ users.api.ts
│     │  ├─ matches.api.ts
│     │  └─ chat.api.ts
│     ├─ store/
│     │  ├─ auth.store.ts
│     │  ├─ user.store.ts
│     │  ├─ game.store.ts
│     │  └─ chat.store.ts
│     └─ utils/
│        ├─ validators.ts
│        ├─ constants.ts
│        └─ formatters.ts
│
├─ scripts/
│  ├─ setup/
│  │  ├─ gen-selfsigned-cert.sh      # certs dev
│  │  └─ init-project.sh             # setup initial
│  ├─ database/
│  │  ├─ migrate.sh                  # lance migrations
│  │  ├─ seed.sh                     # données de démo
│  │  └─ reset.sh                    # reset complet
│  ├─ dev/
│  │  ├─ dev-start.sh
│  │  └─ logs.sh
│  └─ demo/
│     ├─ demo.sh                     # script de démo soutenance
│     └─ test-scenarios.sh
│
└─ _optional/                        # Modules bonus/majeurs non obligatoires
   ├─ graphics-3d/                   # Major Graphics (Babylon.js)
   ├─ remote-auth-google/            # Major Remote Auth (Google Sign-in)
   ├─ server-cli-pong/               # Major: Pong CLI vs Web
   └─ extras/                        # Monitoring, GDPR, etc.


_optional.modules/
├─ gameplay-multi-players/                # Major: >2 joueurs
│  ├─ backend/src/modules/multiplayer/*
│  └─ frontend/src/pages/game/Play4P.ts
├─ gameplay-another-game/                 # Major: second jeu + histo + matchmaking
│  ├─ backend/src/modules/altgame/*
│  └─ frontend/src/pages/AltGame.ts
├─ gameplay-customization/                # Minor: options/power-ups/maps
│  ├─ backend/src/modules/customization/*
│  └─ frontend/src/components/game/OptionsPanel.ts
├─ ai-opponent/                           # Major: IA (1 Hz, input clavier)
│  ├─ backend/src/modules/ai/*
│  └─ frontend/src/game/ai-client-adapter.ts
├─ dashboards/                            # Minor: Stats dashboards
│  └─ frontend/src/pages/Dashboards.ts
├─ cybersecurity-gdpr/                    # Minor: GDPR + anonymisation + delete
│  ├─ backend/src/modules/gdpr/*
│  └─ frontend/src/pages/PrivacyCenter.ts
├─ accessibility/                          # 5 minors possibles
│  ├─ all-devices/                        # responsive & inputs
│  ├─ extra-browser/                      # compat navigateur supplémentaire
│  ├─ i18n/                               # ≥3 langues + switcher
│  ├─ a11y-visually-impaired/             # SR/contraste/focus
│  └─ ssr/                                # SSR integration
└─ server-side-pong/                       # Major: remplacer Pong par server-side + API
   ├─ backend/src/modules/sspong/*
   └─ docs/API-ServerPong.md
