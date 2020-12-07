import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// needed for NumberFormat
// Use special prefix for lib to prevent collitions between same class names from different packages
import 'package:intl/intl.dart' as numberFormatLib;

import '../styles.dart';
import '../model/product.dart';
import '../model/app_state_model.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    @required this.index,
    @required this.product,
    @required this.lastItem,
    @required this.quantity,
    @required this.formatter,
  });

  final Product product;
  final int index; // not used yet
  final bool lastItem; // Important to know for differentiating whether to put an divider afterwards or not
  final int quantity; // used for final calculation (multiplying quantity with price)
  final numberFormatLib.NumberFormat formatter; // Important for changing currency

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context, listen: false);
    final row = SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),

        child: MergeSemantics(
          child: Semantics(

            /***
             * Semantic announcement DOES NOT WORK ON iOS
             * This should be used for announcement that are not seamlessly announced by
             * the system as a result of a UI state change.
             */

            onTap: () {
              model.removeItemFromCart(product.id);
              // give user feedback that the item is successful added to the cart
              SemanticsService.announce('${product.name} removed from cart.', TextDirection.ltr);
            },

            /***
             * "onTapHind" DOES NOT WORK ON IOS
             * for iOS the "hint" is used
             * onTapHint completes the "Double tap to" sentence with the given string
             * in this example: "Double tap to REMOVE FROM CART"
             */

            onTapHint: Platform.isIOS ? null : 'remove from cart.',

            /***
             * "hint" as WORKAROUND ONLY FOR IOS
             * on iOS only the hint is read by the screenreader
             * on Android the hind is read with the additional sentence "Double tap to active"
             * Therefor the hint is only used on iOS devices and the onTapHint is used for Android devices
             */

            hint: Platform.isIOS ? 'Double tap to remove from cart.' : null,

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
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /*** PRODUCT NAME ***/
                Container(
                  width: 120.0,
                  child: Text(
                    product.name,
                    style: Styles.cartProductRowItemName,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /*** PRODUCT TOTAL PRICE ***/
                      Text(
                        '${formatter.format(quantity * product.price)}',
                        // total price -> result of unit price * quantity
                        style: Styles.productRowItemName,
                      ),

                      const SizedBox(height: 4),

                      /*** PRODUCT PRICE ***/
                      Text(
                        '${quantity >= 1 ? '$quantity x ' : ''}'
                            '${formatter.format(product.price)}',
                        style: Styles.productRowItemPrice,
                        semanticsLabel: '${model.getProductCountById(product.id)} times added to cart.',
                      )

                    ],
                  ),
                ),

                const SizedBox(width: 16),

                /*** BUTTON ***/
                ExcludeSemantics(
                  // If the current platform is not iOS, then exclude the button
                  // excluding: Platform.isIOS ? false : true,
                  child: CupertinoButton(
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      final model = Provider.of<AppStateModel>(context, listen: false);
                      model.removeItemFromCart(product.id);
                    },

                    /*** ICON ***/
                    child: const Icon(
                      CupertinoIcons.minus_circled,
                      semanticLabel: 'Remove',
                    ),
                  ),
                ),

              ],
            ),
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
            left: 16,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );
    //return row;
  }
}
