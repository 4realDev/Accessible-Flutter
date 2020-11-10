import 'package:cupertino_store/product_list_tab.dart';
import 'package:cupertino_store/search_tab.dart';
import 'package:cupertino_store/shopping_cart_tab.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'language_adapted_strings.dart';

// launched by runApp
// launches the CupertinoStoreHomePage
class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // BUILD LANGUAGE ADAPTED STRINGS
    LanguageAdaptedStrings.setLanguageAdaptedString();

    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // CupertinoApp from cupertino.dart package as wrapper for the app
    return CupertinoApp(
      // CupertinoStoreHomePage as first loaded screen
      home: CupertinoStoreHomePage()
    );
  }
}

// launches ProductListTab || SearchTab || ShoppingCartTab
// Creates CupertinoTabScaffold with CupertinoTabBar (filled with Array[BottonNavigationBarItem])
// and CupertinoTabView (filled with CupertinoPageScaffold (ProductListTab, SearchTab, ShoppingCartTab))
class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        // Array with BottomNavigationBarItems
        // Remove 'const' to be able to change the Text attribute
        items: /*const*/<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text(LanguageAdaptedStrings.productTab),
          ),

          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            title: Text(LanguageAdaptedStrings.searchTab),
          ),

          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            title: Text(LanguageAdaptedStrings.cartTab),
          ),
        ],
      ),

      tabBuilder: (context, index){
        CupertinoTabView returnValue; // declaring local variable
        switch (index){
          case 0:
            returnValue = CupertinoTabView(builder: (context){
              return CupertinoPageScaffold(
                child: ProductListTab(),
              );
            });
            break;

          case 1:
            returnValue = CupertinoTabView(builder: (context){
              return CupertinoPageScaffold(
                child: SearchTab(),
              );
            });
            break;

          case 2:
            returnValue = CupertinoTabView(builder: (context){
              return CupertinoPageScaffold(
                child: ShoppingCartTab(),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }
}