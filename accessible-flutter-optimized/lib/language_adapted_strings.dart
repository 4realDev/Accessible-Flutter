import 'dart:io';

abstract class LanguageAdaptedStrings {

  /*** PRODUCT TAB / PRODUCT ITEM ***/
  static String productItemHint;
  static String productTabDescription;
  static String productAddAnnouncementSemantic;

  /*** TAB BAR ***/
  static String productTab;
  static String searchTab;
  static String cartTab;

  /*** CART TAB / CART ITEM ***/
  static String cartItemHint;
  static String cartItemRemoveAnnouncementSemantic;
  static String cartListHeading;
  static String cartListCount;
  static String cartListHintSemantic;

  static String productCounterSemantic;

  /*** TEXTFIELD ***/
  static String clearButtonHint;
  static String clearButtonLabel;

  static setLanguageAdaptedString() {
    final String systemLanguage = Platform.localeName; // Returns locale string in the form 'en_US' || 'de_DE';

    switch(systemLanguage) {
      case 'de_DE': {
        // 'Zum x doppelt klicken' is given as Talkback default for Hints
        productTabDescription = 'Willkommen im Cupertino Store. Bitte wählen Sie Ihre gewünschten Produkte aus und gehen Sie zum Warenkorb Tab, um diese zu bestellen.';
        productItemHint = 'in den Warenkorb hinzufügen';
        productAddAnnouncementSemantic = 'zum Warenkorb hinzugefügt.';

        cartItemHint = 'aus dem Warenkorb entfernen.';
        cartItemRemoveAnnouncementSemantic = 'aus dem Warenkorn entfernt.';
        cartListHeading = 'Warenkorb Liste:';
        cartListCount = 'Produkte sind aktuell im Warenkorb.';
        cartListHintSemantic = 'Wischen Sie nach rechts um die Produkte anzuhören.';

        productCounterSemantic = 'Mal zum Warenkorb hinzugefügt.';

        clearButtonHint = 'Löschen des Textes';
        clearButtonLabel = 'Lösch Button';

        productTab = 'Produkte';
        searchTab = 'Suche';
        cartTab = 'Warenkorb';
      }
      break;

      // 'Double tap to x' is given as Talkback default for Hints
      default: {  // default represents the language English with 'en_Us'
        productTabDescription = 'Welcome to the Cupertino Store. Please select your desired products and go to the Cart Tab to order them.';
        productItemHint = 'add to cart';
        productAddAnnouncementSemantic = 'added to cart.';

        cartItemHint = 'remove from cart.';
        cartItemRemoveAnnouncementSemantic = 'removed from cart.';
        cartListHeading = 'Shopping Cart List:';
        cartListCount = 'products currently added.';
        cartListHintSemantic = 'Swipe right to hear the products.';

        productCounterSemantic = 'times added to cart.';

        clearButtonHint = 'clear the text';
        clearButtonLabel = 'Clear Button';

        productTab = 'Products';
        searchTab = 'Search';
        cartTab = 'Cart';
      }
      break;
    }
  }
}