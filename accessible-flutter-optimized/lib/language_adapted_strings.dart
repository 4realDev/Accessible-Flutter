import 'dart:io';

abstract class LanguageAdaptedStrings {

  /*** TAB BAR ***/
  static String productTab;
  static String searchTab;
  static String cartTab;

  /*** PRODUCT TAB / PRODUCT ITEM ***/
  static String productTabDescription;
  static String productItemOnTapHint; // only works on Android
  static String productItemHint;  // used for iOS
  static String productAddSemanticAnnouncement;

  static String productCounterSemantic;

  /*** SEARCH TAB / SEARCHFIELD ***/
  static String searchField;
  static String searchFieldHint;

  /*** CART TAB / CART ITEM ***/

  static String cartItemOnTapHint;
  static String cartItemHint;
  static String cartItemRemoveSemanticAnnouncement;

  static String cartListHeading;
  static String cartListCount;
  static String cartListSemanticHint;

  /*** TEXTFIELD ***/
  static String clearButtonLabel;
  static String clearButtonOnTapHint;
  static String clearButtonHint;
  static String clearButtonSemanticAnnouncement;

  /*** DELIVERYTIME ***/
  static String deliveryTime;

  /*** DISPLAY SHIPPING, TAX AND TOTAL ***/
  static String cartTabShipping;
  static String cartTabTax;
  static String cartTabTotal;

  static setLanguageAdaptedString() {
    final String systemLanguage = Platform.localeName; // Returns locale string in the form 'en_US' || 'de_DE';

    switch(systemLanguage) {
      case 'de_DE': {
        // 'Zum x doppel tippen' is given as Talkback default for Hints
        productTabDescription = 'Willkommen im Cupertino Store. Bitte wählen Sie Ihre gewünschten Produkte aus und gehen Sie zum Warenkorb Tab, um diese zu bestellen.';
        productItemOnTapHint = 'in den Warenkorb hinzufügen';
        productItemHint = 'Zum in den Warenkorb hinzufügen doppel tippen.';
        productAddSemanticAnnouncement = 'zum Warenkorb hinzugefügt.';

        cartItemOnTapHint = 'aus dem Warenkorb entfernen.';
        cartItemHint = 'Zum aus dem Warenkorb entfernen doppel tippen.';
        cartItemRemoveSemanticAnnouncement = 'aus dem Warenkorb entfernt.';
        cartListHeading = 'Warenkorb Liste:';
        cartListCount = 'Produkte sind aktuell im Warenkorb.';
        cartListSemanticHint = 'Wischen Sie nach rechts um die Produkte anzuhören.';

        cartTabShipping = 'Versand';
        cartTabTax = 'MwSt';
        cartTabTotal = 'Gesamt';

        productCounterSemantic = 'Mal zum Warenkorb hinzugefügt.';

        clearButtonLabel = 'Lösch';
        clearButtonOnTapHint = 'Löschen des Textes';
        clearButtonHint = 'Zum Löschen des Textes doppel tippen.';
        clearButtonSemanticAnnouncement = 'Text wurde gelöscht.';

        searchField = 'Suchleiste';

        productTab = 'Produkte';
        searchTab = 'Suche';
        cartTab = 'Warenkorb';

        deliveryTime = 'Lieferzeit: ';
      }
      break;

      // 'Double tap to x' is given as Talkback default for Hints
      default: {  // default represents the language English with 'en_Us'
        productTabDescription = 'Welcome to the Cupertino Store. Please select your desired products and go to the Cart Tab to order them.';
        productItemOnTapHint = 'add to cart';
        productItemHint = 'Double tap to add to cart.';
        productAddSemanticAnnouncement = 'added to cart.';

        cartItemOnTapHint = 'remove from cart.';
        cartItemHint = 'Double tap to remove from cart.';
        cartItemRemoveSemanticAnnouncement = 'removed from cart.';
        cartListHeading = 'Shopping Cart List:';
        cartListCount = 'products currently added.';
        cartListSemanticHint = 'Swipe right to hear the products.';

        cartTabShipping = 'Shipping';
        cartTabTax = 'Tax';
        cartTabTotal = 'Total';

        productCounterSemantic = 'times added to cart.';

        clearButtonLabel = 'Clear';
        clearButtonOnTapHint = 'clear the text.';
        clearButtonHint = 'Double tap to clear the text.';
        clearButtonSemanticAnnouncement = 'Text cleared.';

        searchField = 'Search Field';

        productTab = 'Products';
        searchTab = 'Search';
        cartTab = 'Cart';

        deliveryTime = 'Delivery time: ';
      }
      break;
    }
  }
}