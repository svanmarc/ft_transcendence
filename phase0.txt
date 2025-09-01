ft_transcendence/
├─ README.md
├─ .gitignore
├─ .env.example
├─ Makefile
│
├─ docs/
│  ├─ EVALUATION.md
│  ├─ SECURITY.md
│  ├─ MODULES.md
│  ├─ GAME_DESIGN.md
│
├─ infra/
│  ├─ docker-compose.yml
│  ├─ reverse-proxy/
│  │  ├─ conf.d/
│  │  │  ├─ spa.conf
│  │  │  ├─ api.conf
│  │  │  └─ ws.conf
│  │  └─ certs/
│  └─ scripts/
│     ├─ gen-certs.sh
│     └─ wait-for.sh
│
├─ backend/
│  ├─ app/
│  │  └─ main.ts
│  ├─ modules/
│  │  └─ health/
│  │     └─ index.ts
│  ├─ db/
│  │  ├─ migrations/
│  │  └─ seed/
│  ├─ scripts/
│  │  ├─ migrate.sh
│  │  ├─ seed.sh
│  │  └─ reset.sh
│  └─ shared/
│     └─ index.ts
│
├─ frontend/
│  ├─ public/
│  │  └─ index.html
│  └─ src/
│     ├─ app/
│     ├─ pages/
│     │  ├─ Home/
│     │  ├─ game/
│     │  │  ├─ PlayLocal/
│     │  │  │  └─ README.txt
│     │  │  └─ Tournament/
│     │  │     └─ README.txt
│     ├─ components/
│     ├─ store/
│     ├─ api/
│     ├─ game/
│     ├─ styles/
│     │  └─ tailwind.css
│     └─ types/
│
└─ shared/
   └─ dto/
      └─ index.ts


make down → stoppe les conteneurs

make re → rebuild & relance

make clean → supprime les conteneurs

make fclean → supprime conteneurs + images + volumes

make logs → affiche les logs