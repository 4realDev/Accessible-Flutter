import 'package:cupertino_store/product_list_tab.dart';
import 'package:cupertino_store/search_tab.dart';
import 'package:cupertino_store/shopping_cart_tab.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// launched by runApp
// launches the CupertinoStoreHomePage
class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // CupertinoApp from cupertino.dart package as wrapper for the app
    return CupertinoApp(
      // CupertinoStoreHomePage as first loaded screen
      home: Semantics(
          label: "Hello Yellow Mellow Baby",
          child: CupertinoStoreHomePage()
      ),
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
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Products'),
          ),

          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            title: Text('Search'),
          ),

          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            title: Text('Cart'),
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