import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';
import '../model/product.dart';
import '../styles.dart';

class ProductRowItem extends StatelessWidget {
  const ProductRowItem({
    this.index,
    this.product,
    this.lastItem,
  });

  final Product product;
  final int index;
  final bool lastItem;  // Important to know for differentiating whether to put an divider afterwards or not

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context, listen: false);
    int count = 0;
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),

      child: Row(
        children: <Widget>[

          /*** IMAGE ***/
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit: BoxFit.cover,
              width: 76,
              height: 76,
            ),
          ),

          /*** TEXT ***/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /*** PRODUCT NAME ***/
                  Text(
                    product.name,
                    style: Styles.productRowItemName,
                  ),

                  const Padding(padding: EdgeInsets.only(top: 8)),

                  /*** PRODUCT PRICE ***/
                  Semantics(
                    label: '${product.price}\$, ${model.getProductCountById(product.id)} times added to cart',
                    child: ExcludeSemantics(
                      child: Text(
                        '${model.getProductCountById(product.id)} x ${product.price}\$',
                        style: Styles.productRowItemPrice,
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            icon: Icon(Icons.add),
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            enableFeedback: true, // is not provided in CupertinoButton, FloatingActionButton
            iconSize: 24.0,
            onPressed: () {
              model.addProductToCart(product.id);
              SemanticsService.announce("${product.name} added to cart", TextDirection.ltr);
            },
          ),

          /*
          /*** ICON ***/
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              final model = Provider.of<AppStateModel>(context, listen: false);
              model.addProductToCart(product.id);
            },
            child: const Icon(
              CupertinoIcons.plus_circled,
              semanticLabel: 'Add',
            ),
          ),
          */

        ],
      ),
    );

    if (lastItem) {
      return row;
    }

    /*** DIVIDER ***/
    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );

  }

  /*void showToast(BuildContext context, Product currentProduct) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text("${currentProduct.name} added to cart"),
        duration: new Duration(seconds: 2),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }*/
}