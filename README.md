# MarketShop - Version Flutter

**Développé par :** prenom-nom
**Technologie :** Flutter avec Dart

## Description
MarketShop est une application de mini e-commerce qui permet de parcourir un catalogue de produits via l'API FakeStore, d'ajouter des articles à un panier, de passer commande et de consulter son historique.

## Fonctionnalités implémentées
- [x] Écran Catalogue (Grille 2 colonnes, API, Filtres, Chargement)
- [x] Écran Détail Produit (Affichage complet, Sélecteur quantité, Ajout panier)
- [x] Écran Panier (Liste locale, Modification, Suppression, Total, Commande)
- [x] Écran Commande (Formulaire validé, Sauvegarde locale, Redirection)
- [x] Écran Historique (Liste locale des commandes passées)
- [x] Écran Profil (Infos utilisateur, Mode Sombre, Suppression de données)

## Bibliothèques utilisées
- `http`: ^1.6.0
- `sqflite`: ^2.4.2
- `provider`: ^6.1.5
- `cached_network_image`: ^3.4.1
- `go_router`: ^17.2.3
- `intl`: ^0.20.2
- `shared_preferences`: ^2.5.2

## Captures d'écran
*(Ajoutez ici 3 captures d'écran de l'application)*
1. ![Catalogue](./screenshots/catalogue.png)
2. ![Panier](./screenshots/panier.png)
3. ![Historique](./screenshots/historique.png)

## Difficultés rencontrées
La gestion de l'état asynchrone avec SQLite et Provider a nécessité une attention particulière pour assurer que l'interface se mette à jour instantanément lors des ajouts au panier. J'ai résolu cela en m'assurant que `notifyListeners()` est appelé uniquement après que la base de données locale confirme l'enregistrement des données.

## Améliorations possibles
Si j'avais plus de temps, j'aurais implémenté des tests unitaires, un système d'authentification complet, et une animation de transition plus fluide entre les écrans lors de l'ajout au panier (par exemple, une animation de l'image du produit volant vers l'icône du panier).

## Lien vers la version React Native
[Dépôt React Native](https://github.com/votre-compte/marketshop-reactnative-prenom-nom)
