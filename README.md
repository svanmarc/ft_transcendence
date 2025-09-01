# ft_transcendence

## 📌 Intro
Projet **ft_transcendence** (version 16.1) — création d’un site web complet autour du jeu Pong.  
Objectif : réaliser un **SPA en TypeScript** (compatible Firefox) avec **backend Fastify/Node.js** et **SQLite**, déployé via **Docker** en une seule commande (`make up`).  
Le projet inclut : Pong jouable en local → en ligne → tournoi, gestion utilisateurs, sécurité (JWT + 2FA), chat, IA, et plusieurs modules bonus.

## ⚙️ Prérequis
- Docker  
- docker-compose  
- Make  
- Node.js + npm/yarn (pour le frontend)  
- OpenSSL (pour générer les certificats TLS en dev)

## 🚀 Lancer le projet
Tout doit se lancer avec une seule commande :  

```bash
make up
