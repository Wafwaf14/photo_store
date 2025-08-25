import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // App
      'app_title': 'Photo Store',
      'photo_store': 'Photo Store',
      
      // Authentication
      'email': 'Email',
      'password': 'Password',
      'sign_in': 'Sign In',
      'sign_up': 'Sign Up',
      'sign_out': 'Sign Out',
      'email_required': 'Email is required',
      'email_invalid': 'Invalid email address',
      'password_required': 'Password is required',
      'password_short': 'Password must be at least 6 characters',
      'no_account': 'Don\'t have an account? Sign Up',
      'have_account': 'Already have an account? Sign In',
      
      // Categories
      'all': 'All',
      'nature': 'Nature',
      'urban': 'Urban',
      'abstract': 'Abstract',
      'wildlife': 'Wildlife',
      
      // Photo Details
      'photographer': 'Photographer',
      'description': 'Description',
      'photo_description': 'This stunning high-resolution photograph captures a unique moment in time. Perfect for home decor, office spaces, or digital projects. The image comes with full commercial license and is available for immediate download after purchase.',
      'features': 'Features',
      'high_quality': 'High Quality Resolution',
      'instant_download': 'Instant Download',
      'print_ready': 'Print Ready',
      'licensed': 'Fully Licensed',
      
      // Cart
      'shopping_cart': 'Shopping Cart',
      'add_to_cart': 'Add to Cart',
      'added_to_cart': 'Added to cart',
      'empty_cart': 'Your cart is empty',
      'item_removed': 'Item removed from cart',
      'total': 'Total',
      'checkout': 'Proceed to Checkout',
      'checkout_message': 'Checkout functionality coming soon!',
    },
    'fr': {
      // App
      'app_title': 'Boutique Photo',
      'photo_store': 'Boutique Photo',
      
      // Authentication
      'email': 'Email',
      'password': 'Mot de passe',
      'sign_in': 'Se connecter',
      'sign_up': 'S\'inscrire',
      'sign_out': 'Déconnexion',
      'email_required': 'L\'email est requis',
      'email_invalid': 'Adresse email invalide',
      'password_required': 'Le mot de passe est requis',
      'password_short': 'Le mot de passe doit contenir au moins 6 caractères',
      'no_account': 'Pas de compte? S\'inscrire',
      'have_account': 'Déjà un compte? Se connecter',
      
      // Categories
      'all': 'Tout',
      'nature': 'Nature',
      'urban': 'Urbain',
      'abstract': 'Abstrait',
      'wildlife': 'Faune',
      
      // Photo Details
      'photographer': 'Photographe',
      'description': 'Description',
      'photo_description': 'Cette magnifique photographie haute résolution capture un moment unique. Parfaite pour la décoration intérieure, les espaces de bureau ou les projets numériques. L\'image est livrée avec une licence commerciale complète et est disponible en téléchargement immédiat après l\'achat.',
      'features': 'Caractéristiques',
      'high_quality': 'Résolution haute qualité',
      'instant_download': 'Téléchargement instantané',
      'print_ready': 'Prêt à imprimer',
      'licensed': 'Entièrement sous licence',
      
      // Cart
      'shopping_cart': 'Panier',
      'add_to_cart': 'Ajouter au panier',
      'added_to_cart': 'Ajouté au panier',
      'empty_cart': 'Votre panier est vide',
      'item_removed': 'Article retiré du panier',
      'total': 'Total',
      'checkout': 'Procéder au paiement',
      'checkout_message': 'Fonctionnalité de paiement bientôt disponible!',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}