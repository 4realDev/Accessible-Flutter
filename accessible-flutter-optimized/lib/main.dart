import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'model/app_state_model.dart';

void main() {
  return runApp(
    // wiring AppStateModel at the top of the widget tree to make it available thoughout the entire app
    // ChangeNotifierProvider provides the defined data model down the tree
    ChangeNotifierProvider<AppStateModel>(
      // loadProducts (app_state_model) calls loadProducts() in ProductRepository, which returns a List<Product> with all Products
      // Afterwards all Listeners get notified (notifyListeners)
      create: (context) => AppStateModel()..loadProducts(),
      child: CupertinoStoreApp(),
    ),
  );
}

