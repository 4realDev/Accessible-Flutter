import 'dart:io';

abstract class LanguageAdaptedStrings {

  static String productItemHint;
  static String clearButtonHint;
  static String clearButtonLabel;

  static setLanguageAdaptedString() {
    final String systemLanguage = Platform.localeName; // Returns locale string in the form 'en_US' || 'de_DE';

    switch(systemLanguage) {
      case "de_DE": {
        // "Zum x doppelt klicken" is given as Talkback default for Hints
        productItemHint = "in den Warenkorb hinzufügen";
        clearButtonHint = "Löschen des Textes";
        clearButtonLabel = "Lösch Button";
      }
      break;

      // "Double tap to x" is given as Talkback default for Hints
      default: {  // default represents the language English with "en_Us"
        productItemHint = "add to cart";
        clearButtonHint = "clear the text";
        clearButtonLabel = "Clear Button";
      }
      break;
    }
  }
}