import 'dart:io';

abstract class LanguageAdaptedStrings {

  static String productItemHint;
  static String clearButtonHint;
  static String clearButtonLabel;
  static String productTabDescription;
  static String productCounterSemantic;
  static String productAddAnnouncementSemantic;
  static String productTab;
  static String searchTab;
  static String cartTab;

  static setLanguageAdaptedString() {
    final String systemLanguage = Platform.localeName; // Returns locale string in the form 'en_US' || 'de_DE';

    switch(systemLanguage) {
      case 'de_DE': {
        // 'Zum x doppelt klicken' is given as Talkback default for Hints
        productItemHint = 'in den Warenkorb hinzufügen';
        clearButtonHint = 'Löschen des Textes';
        clearButtonLabel = 'Lösch Button';
        productTabDescription = 'Willkommen im Cupertino Store. Bitte wählen Sie Ihre gewünschten Produkte aus und gehen Sie zum Warenkorb Tab, um diese zu bestellen.';
        productCounterSemantic = 'Mal zum Warenkorb hinzugefügt.';
        productAddAnnouncementSemantic = 'zum Warenkorb hinzugefügt.';
        productTab = 'Produkte';
        searchTab = 'Suche';
        cartTab = 'Warenkorb';
      }
      break;

      // 'Double tap to x' is given as Talkback default for Hints
      default: {  // default represents the language English with 'en_Us'
        productItemHint = 'add to cart';
        clearButtonHint = 'clear the text';
        clearButtonLabel = 'Clear Button';
        productTabDescription = 'Welcome to the Cupertino Store. Please select your desired products and go to the Cart Tab to order them.';
        productCounterSemantic = 'times added to cart.';
        productAddAnnouncementSemantic = 'added to cart.';
        productTab = 'Products';
        searchTab = 'Search';
        cartTab = 'Cart';
      }
      break;
    }
  }
}