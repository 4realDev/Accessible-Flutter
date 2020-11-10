import 'package:cupertino_store/model/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import '../model/product.dart';

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem({
    @required this.index,
    @required this.product,
    @required this.lastItem,
    @required this.quantity,
    @required this.formatter,
  });

  final Product product;
  final int index;              // not used yet
  final bool lastItem;          // Important to know for differentiating whether to put an divider afterwards or not
  final int quantity;           // used for final calculation (multiplying quantity with price)
  final NumberFormat formatter; // Important for changing currency

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),

            const SizedBox(
              width: 16,
            ),

            Container(
              width: 120.0,
                child: Text(
                  product.name,
                  style: Styles.cartProductRowItemName,
                ),
            ),

            const SizedBox(
              width: 16,
            ),

            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                        Text(
                          '${formatter.format(quantity * product.price)}',
                          style: Styles.productRowItemName,
                        ),
                    
                    const SizedBox(
                      height: 4,
                    ),
                    
                    Text(
                      '${quantity >= 1 ? '$quantity x ' : ''}'
                          '${formatter.format(product.price)}',
                      style: Styles.productRowItemPrice,
                    )
                  ],
                ),
            ),

            const SizedBox(
              width: 16,
            ),

            /*** BUTTON ***/
            ExcludeSemantics(
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