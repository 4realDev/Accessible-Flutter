import 'package:cupertino_store/language_adapted_strings.dart';
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
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),

      // Raw Screen-Reading: "Product name. Rroduct price. Add Button, double tap to activate."
      // Step 1: Wrap whole item with the Semantics Widget

      // Step 2: Create own logic for the onTap event and adjust the onTapHint to "Double tap to add to cart."
      // Problem: Now we have two items, that can be tapped/pressed.
      // Because of this the CupertinoButton is now seen as a separate Semantic Widget in the Semantic-Tree
      // Screen-Reading: "Product name. Product price. Double tap to add to cart." SWIPE_LEFT "Add Button. Double tap to activate."
      // Possible Solution: Wrap everything in a MergeSemantics Widget - Problem: the Semantic Meaning of the CupertinoButton will be still visible and readable for the screen-readers
      // Screen-Reading: "Product name. Product price. ADD BUTTON. Double tap to add to cart."
      // Solution: Step 3

      // Step 3: Exclude the CupertinoButton from the Semantic tree
      // Exclude the ClipRRect as well, because it has no semantic meaning
      // To achieve this, wrap the CupertinoButton and the ClipRRect with the ExcludeSemantics Widget
      // This achieves as well, that the onPressed() event can only be triggered when the screen-reader is disabled,
      // and on the opposite the onTap() event can not be triggered when the screen-reader is enabled
      // Screen-Reading: "Product name. Product price. Double tap to add to cart."

      child: MergeSemantics(
        child: Semantics(
          /*
          SemanticsService announcement is only necessary in the Semantic wrapper.
          If the semantics wrapper is tapped, the announcement occurs and the user gets haptic feedback,
          that symbolizes, that the item is successful added to the cart
           */

          onTap: () {
            model.addProductToCart(product.id);
            SemanticsService.announce("${product.name} added to cart", TextDirection.ltr);
          },

          // onTapHint completes the "Double tap to" sentence with the given string
          onTapHint: LanguageAdaptedStrings.productItemHint/*"add to cart"*/,

          child: Row(
            children: <Widget>[

              /*** IMAGE ***/
              // to ensure that screen-readers are not reading "Image"
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

                      const Padding(padding: EdgeInsets.only(top: 8)),

                      /*** PRODUCT PRICE ***/
                      Text(
                        '\$${product.price}',
                          style: Styles.productRowItemPrice,
                      ),

                    ],
                  ),
                ),
              ),


              /*** BUTTON ***/
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  model.addProductToCart(product.id);
                },

                /*** ICON ***/
                child: const Icon(
                  CupertinoIcons.plus_circled,
                  semanticLabel: 'Add',
                ),
              ),


            ],
          ),
        ),
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

  void displayDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new Semantics(
        //onDidGainAccessibilityFocus: ?,
        //?? onSetSelection ??
        onDidGainAccessibilityFocus: () { debugPrint('All right, do not do that again though.'); },
        child: CupertinoAlertDialog(
          title: new Text("Item added to cart"),
          insetAnimationDuration: const Duration(milliseconds: 100),
          actions: <Widget>[
            new CupertinoDialogAction(
                child: const Text('Discard'),
                isDestructiveAction: true,
                isDefaultAction: true,
                onPressed: () { Navigator.pop(context, 'Discard'); }
            ),
          ],
        ),
      ),
    );
  }
}



/*
child: Semantics(
  onTap: () {
    model.addProductToCart(product.id);
  },

  // onTapHint completes the "Double tap to" sentence with the given string
  onTapHint: LanguageAdaptedStrings.productItemHint/*"add to cart"*/,

  child: Row(
    children: <Widget>[

      /*** IMAGE ***/
      // to ensure that screen-readers are not reading "Image"
      ExcludeSemantics(
        child: ClipRRect(
          child: Image.asset(
            ...
          ),
        ),
      ),

      /*** PRODUCT NAME ***/
      Text(
        product.name,
      ),

      /*** PRODUCT PRICE ***/
      Text(
        '\$${product.price}',
      ),

      /*** BUTTON ***/
      ExcludeSemantics(
        child: CupertinoButton(
          onPressed: () {
            model.addProductToCart(product.id);
          },

          /*** ICON ***/
          child: const Icon(
            CupertinoIcons.plus_circled,
            semanticLabel: 'Add',
          ),
        ),
      ),
    ],
  ),
);

*/