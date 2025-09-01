# 🕹️ Game Design — ft_transcendence

## Règles Pong (Mandatory)
- 2 joueurs sur un clavier (local)
- Mouvements verticaux uniquement
- Même vitesse pour les deux joueurs
- Score affiché

## Tournoi Offline
- Entrée des alias au début
- Génération d’un bracket simple
- Affichage des matchs dans l’ordre
- Les alias sont réinitialisés à chaque tournoi

## Gestion de la latence (pour Remote)
- Synchronisation via WS
- Reconnexion possible
- Best UX possible

## Personnalisation (Minor)
- Options : vitesse balle/paddle, power-ups, maps
- Choix d’une version “classique” simple

## IA (Major)
- L’IA rafraîchit sa vue toutes les 1s
- Simule des inputs clavier
- Doit pouvoir gagner parfois
