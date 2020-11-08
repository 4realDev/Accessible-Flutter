import 'package:flutter/material.dart';
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
            /*const SliverAppBar(
              title: Text('Cupertino Store'),
            ),*/

            SliverAppBar(
              floating: true,
              pinned: false,
              snap: false,
              title: Text('Cupertino store'),
              //expandedHeight: 80.0,
              /*flexibleSpace: const FlexibleSpaceBar(
                title: Text('Available seats'),
                centerTitle: false,
                titlePadding: EdgeInsets.all(16),
              ),*/
            ),

            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
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