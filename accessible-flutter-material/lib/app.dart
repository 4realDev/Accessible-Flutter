import 'package:cupertino_store/product_list_tab.dart';
import 'package:cupertino_store/search_tab.dart';
import 'package:cupertino_store/shopping_cart_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'language_adapted_strings.dart';

// launched by runApp
// launches the CupertinoStoreHomePage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Material Design Store";
    // BUILD LANGUAGE ADAPTED STRINGS
    //LanguageAdaptedStrings.setLanguageAdaptedString();

    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // CupertinoApp from cupertino.dart package as wrapper for the app
    return MaterialApp(
      title: title,
      home: Home(),
    );
  }
}


/// This is the stateful widget that the main application instantiates.
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String _selectedTitle = "Test0";
  /*static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);*/
  List<Widget> _widgetOptions = <Widget>[
    ProductListTab(),
    SearchTab(),
    ShoppingCartTab()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex){
        case 0:
          _selectedTitle = "Test0";
          break;
        case 1:
          _selectedTitle = "Test1";
          break;
        case 2:
          _selectedTitle = "Test2";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(_selectedTitle),
      ),*/
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Products'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

/*

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

*/