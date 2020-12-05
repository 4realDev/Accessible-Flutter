import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),

      child: MergeSemantics(
        child: Semantics(

          onTap: (){},
          onTapHint: Platform.isIOS ? null : "add to cart",
          hint: Platform.isIOS ? "Double tap to add to cart": null,

          child: Row(
            children: <Widget>[

              /*** IMAGE ***/
              ExcludeSemantics(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    product.assetName,
                    package: product.assetPackage,
                    fit: BoxFit.cover,
                    width: 76,
                    height: 76,
                  ),
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

                      /*** PRODUCT PRICE ***/
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        '\$${product.price}',
                        style: Styles.productRowItemPrice,
                      )

                    ],
                  ),
                ),
              ),

              /*** ICON ***/
              ExcludeSemantics(
                child: CupertinoButton(
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
              )
            ],
          ),
        )

      )
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
}