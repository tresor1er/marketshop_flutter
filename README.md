# MarketShop - Application E-Commerce (Version Flutter)

**Réalisé par :** Tresor Kolombia

---

## 🛠 Technologie Utilisée
* **Technologie principale :** Flutter

## 📖 Description de l'application
MarketShop est une application mobile d'e-commerce complète et moderne. Elle permet aux utilisateurs de parcourir un catalogue de produits, de consulter les détails de chaque article (prix en FCFA, description, catégorie), d'ajouter des produits à leur panier, de passer une commande et de consulter l'historique de leurs achats. L'application intègre une gestion avancée du thème (clair/sombre).

## ✨ Fonctionnalités implémentées
* ✅ Affichage du catalogue de produits
* ✅ Affichage des détails d'un produit
* ✅ Gestion du panier (Ajouter, modifier la quantité, supprimer)
* ✅ Validation de la commande (Checkout avec formulaire)
* ✅ Historique des commandes passées
* ✅ Gestion du profil utilisateur
* ✅ Support du Thème Clair / Sombre
* ✅ Conversion automatique des prix en FCFA
* ✅ Interface entièrement traduite en français

## 📦 Bibliothèques utilisées
* `flutter` (SDK)
* `provider`: ^6.1.5+1 (Pour la gestion de l'état global)
* `http`: ^1.6.0 (Pour les appels API)
* `go_router`: ^17.2.3 (Pour le routage et la navigation)
* `shared_preferences`: ^2.5.5 (Pour le stockage local des préférences)
* `cached_network_image`: ^3.4.1 (Pour l'optimisation des images)

## 📸 Captures d'écran
*(Remplacez les liens ci-dessous par les vraies images de votre application, placez vos images dans le dépôt et liez-les ici)*

1. ![Catalogue](lien_vers_image_catalogue.png)
2. ![Détail Produit](lien_vers_image_detail.png)
3. ![Panier](lien_vers_image_panier.png)

## 🚧 Difficultés rencontrées et solutions
L'un des défis majeurs a été la structuration de la navigation avec `go_router` tout en préservant l'état du panier et des commandes. L'utilisation du package `provider` couplée au routeur a nécessité une architecture rigoureuse (MultiProvider à la racine). La solution a été d'extraire la logique métier dans des classes Providers dédiées (`CartProvider`, `OrderProvider`), séparant ainsi l'UI de la logique de données.

## 🚀 Améliorations possibles
Avec plus de temps, l'intégration d'un système de paiement de test (comme Stripe) aurait rendu le flux de commande plus réaliste. De plus, j'aurais aimé ajouter des animations de transition plus fluides entre les écrans (Hero animations pour les images des produits) pour donner un rendu encore plus "premium" à l'application.

---

🔗 **Lien vers la version React Native du projet :** [Insérez ici le lien de votre dépôt GitHub React Native]
