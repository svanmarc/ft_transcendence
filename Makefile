# =========================
# ft_transcendence — Makefile (Phase 0)
# Objectif : "one command" prêt, avec garde-fous et utilitaires
# =========================

SHELL := /bin/bash

PROJECT_NAME := ft_transcendence
COMPOSE_FILE := infra/docker-compose.yml
COMPOSE := $(shell command -v docker-compose >/dev/null 2>&1 && echo docker-compose || echo docker compose)

CERT_SCRIPT := infra/scripts/gen-certs.sh
WAIT_SCRIPT := infra/scripts/wait-for.sh
ENV_FILE := .env
ENV_EXAMPLE := .env.example

.PHONY: help up down re logs ps clean fclean check env certs init tree

# -------- HELP (default) --------
help:
	@echo "ft_transcendence — Phase 0"
	@echo
	@echo "Cibles disponibles :"
	@echo "  make up       : Lancer le stack (échoue proprement si compose pas prêt)"
	@echo "  make down     : Stopper les conteneurs"
	@echo "  make re       : Rebuild + relance"
	@echo "  make logs     : Suivre les logs"
	@echo "  make ps       : Lister les services"
	@echo "  make env      : Générer .env depuis .env.example si absent"
	@echo "  make certs    : Lancer le script de génération des certs (Phase 0.1)"
	@echo "  make check    : Vérifier prérequis (compose/services/env/certs)"
	@echo "  make init     : Créer dossiers/placeholder utiles (sans logique)"
	@echo "  make clean    : Arrêt + nettoyage conteneurs"
	@echo "  make fclean   : Nettoyage dur (conteneurs + images + volumes) — à activer en Phase 1"
	@echo

# -------- GUARDS --------
_guard-compose-exists:
	@test -f "$(COMPOSE_FILE)" || (echo "❌ $(COMPOSE_FILE) introuvable. Place-le sous infra/"; exit 1)

_guard-compose-services:
	@grep -qE '^[[:space:]]*services:' "$(COMPOSE_FILE)" || ( \
		echo "❌ $(COMPOSE_FILE) ne contient pas 'services:' pour l'instant."; \
		echo "   👉 Phase 0 : normal si tu n'as pas encore configuré les services."; \
		echo "   Quand prêt, ajoute au moins: services: { reverse-proxy, frontend, backend, db }"; \
		exit 1)

_guard-env:
	@test -f "$(ENV_FILE)" || (echo "ℹ️  $(ENV_FILE) manquant. Lance 'make env' pour le créer depuis $(ENV_EXAMPLE)."; exit 1)

_guard-certs:
	@test -f infra/reverse-proxy/certs/localhost.crt -a -f infra/reverse-proxy/certs/localhost.key || ( \
		echo "ℹ️  Certificats TLS dev manquants. Lance 'make certs' (Phase 0.1)."; exit 1)

# -------- CORE --------
up: _guard-compose-exists _guard-compose-services _guard-env
	@echo "🚀 Lancement du stack ($(PROJECT_NAME))..."
	$(COMPOSE) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d

down: _guard-compose-exists
	@echo "⏹  Arrêt des services..."
	$(COMPOSE) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down

re: _guard-compose-exists _guard-compose-services _guard-env
	@echo "🔁 Rebuild + relance..."
	$(COMPOSE) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d --build

logs: _guard-compose-exists
	$(COMPOSE) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) logs -f

ps: _guard-compose-exists
	$(COMPOSE) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) ps

# -------- UTILITAIRES --------
check: _guard-compose-exists
	@echo "🔎 Vérification Phase 0..."
	@echo "- Compose présent : OK"
	@if grep -qE '^[[:space:]]*services:' "$(COMPOSE_FILE)"; then \
		echo "- services: détecté dans $(COMPOSE_FILE) : OK"; \
	else \
		echo "- services: NON détecté (Phase 0 : normal si non configuré)"; \
	fi
	@if test -f "$(ENV_FILE)"; then echo "- $(ENV_FILE) présent : OK"; else echo "- $(ENV_FILE) manquant (make env)"; fi
	@if test -f infra/reverse-proxy/certs/localhost.crt -a -f infra/reverse-proxy/certs/localhost.key; then \
		echo "- Certs TLS dev présents : OK"; \
	else \
		echo "- Certs TLS dev manquants (make certs)"; \
	fi

env:
	@test -f "$(ENV_EXAMPLE)" || (echo "❌ $(ENV_EXAMPLE) manquant. Crée-le d'abord." && exit 1)
	@test -f "$(ENV_FILE)" && echo "✅ $(ENV_FILE) existe déjà. (Rien à faire)" || (cp "$(ENV_EXAMPLE)" "$(ENV_FILE)" && echo "🆗 Copié $(ENV_EXAMPLE) → $(ENV_FILE)")

certs:
	@test -f "$(CERT_SCRIPT)" || (echo "❌ Script $(CERT_SCRIPT) manquant." && exit 1)
	@chmod +x "$(CERT_SCRIPT)" || true
	@echo "🔐 Génération des certificats (dev)..."
	@$(CERT_SCRIPT) || (echo "ℹ️  Remplis $(CERT_SCRIPT) en Phase 0.1 (opensssl autosigné)"; exit 1)

init:
	@mkdir -p infra/reverse-proxy/certs infra/database/vol
	@touch infra/reverse-proxy/conf.d/spa.conf infra/reverse-proxy/conf.d/api.conf infra/reverse-proxy/conf.d/ws.conf
	@echo "🧰 Dossiers/cf placeholders prêts."

tree:
	@command -v tree >/dev/null 2>&1 && tree -a -I 'node_modules|dist|build|.git' || (echo "ℹ️  'tree' non installé. Utilise 'ls -R'.")

# -------- CLEAN --------
clean: _guard-compose-exists
	@echo "🧹 Arrêt + nettoyage des conteneurs..."
	-$(COMPOSE) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down --remove-orphans

fclean: _guard-compose-exists
	@echo "🧨 Nettoyage dur (⚠️ volumes & images) — Active-le quand tes services seront définis."
	@echo "     Exemple (à activer en Phase 1) :"
	@echo "     $(COMPOSE) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down -v --rmi local"
