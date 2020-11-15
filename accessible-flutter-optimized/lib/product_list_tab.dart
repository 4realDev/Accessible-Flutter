import 'package:cupertino_store/language_adapted_strings.dart';
import 'package:cupertino_store/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'layout/product_list_item.dart';

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final products = model.getProducts();
        return CustomScrollView(
          semanticChildCount: products.length,
          slivers: <Widget>[

            /*** NAVIGATION-BAR ***/
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Cupertino Store'),
            ),

            /*** INTRO-TEXT ***/
            SliverToBoxAdapter(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  minimum: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    bottom: 32,
                    right: 16,
                  ),
                  child: Text(
                      LanguageAdaptedStrings.productTabDescription,
                      style: Styles.productTabDescription,
                  ),
                ),
            ),

            /*** ROW-DIVIDER ***/
            SliverToBoxAdapter(
                child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      right: 0,
                    ),
                    child: Container(
                      height: 1,
                      color: Styles.productRowDivider,
                    ),
                  ),
                ],
            ),
            ),

            /*** PRODUCT-LIST ***/
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < products.length) {
                      return ProductRowItem(
                        index: index,
                        product: products[index],
                        lastItem: index == products.length - 1,
                      );
                    }
                    // If there are no products left, return null
                    return null;
                  },
                ),
              ),
            )

          ],
        );
      },
    );
  }
}