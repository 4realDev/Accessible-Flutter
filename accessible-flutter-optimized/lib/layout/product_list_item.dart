import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../styles.dart';
import '../language_adapted_strings.dart';
import '../model/product.dart';
import '../model/app_state_model.dart';

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

      child: MergeSemantics(
        child: Semantics(

          // Semantic announcement DOES NOT WORK ON iOS
          // SemanticsService announcement is only necessary in the Semantic wrapper.
          // If the semantics wrapper is tapped, the announcement occurs and the user gets haptic feedback,

          // give user feedback that the item is successful added to the cart
          onTap: () {
            model.addProductToCart(product.id);
            SemanticsService.announce('${product.name} ${LanguageAdaptedStrings.productAddSemanticAnnouncement}', TextDirection.ltr);
          },

          /***
           * "onTapHind" DOES NOT WORK ON IOS
           * for iOS the "hint" is used
           * onTapHint completes the "Double tap to" sentence with the given string
           * in this example: "Double tap to ADD TO CART"
           */

          onTapHint: Platform.isIOS ? null : LanguageAdaptedStrings.productItemHint/*"add to cart"*/,

          /***
           * "hint" as WORKAROUND ONLY FOR IOS
           * on iOS only the hint is read by the screenreader
           * on Android the hind is read with the additional sentence "Double tap to active"
           * Therefor the hint is only used on iOS devices and the onTapHint is used for Android devices
           */

          hint: Platform.isIOS ? "Double tap to add to cart" : null,



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

                      Text(
                        '${model.getProductCountById(product.id)} x \$${product.price}',
                        // product count times added to cart / produkt count Mal zum Warenkorb hinzugefügt
                        semanticsLabel: '\$${product.price}, ${model.getProductCountById(product.id)} ${LanguageAdaptedStrings.productCounterSemantic}',
                        style: Styles.productRowItemPrice,
                      ),
                    ],
                  ),
                ),
              ),


              /*** BUTTON ***/
              ExcludeSemantics(
                //excluding: Platform.isIOS ? false : true,
                child: CupertinoButton(
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
              )
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
}