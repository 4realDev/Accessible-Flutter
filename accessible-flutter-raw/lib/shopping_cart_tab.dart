import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'layout/shopping_cart_item.dart';
import 'package:intl/intl.dart';  // needed for DateFormat.yMMMd()
import 'styles.dart';

const double _kDateTimePickerHeight = 216;  // height of the DateTimePicker

class ShoppingCartTab extends StatefulWidget{
  @override
  _ShoppingCartTabState createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab>{

  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();
  // Currency formatter - used in calculations
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  Widget _buildNameField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.person_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Name',
      onChanged: (newName) {
        setState(() {
          name = newName;
        });
      },
    );
  }

  Widget _buildEmailField() {
    return const CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.mail_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Email',
    );
  }

  Widget _buildLocationField() {
    return const CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.location_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Location',
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  'Delivery time',
                  style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime), // default Time = DateTime.now()
              style: Styles.deliveryTime,
            ),
          ],
        ),
        Container(
          height: _kDateTimePickerHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: dateTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCartDesciptionText(BuildContext context) {
    final model = Provider.of<AppStateModel>(context, listen: false);
    return SafeArea(
      top: false,
      bottom: false,
      child: Semantics(
        // If there are more then 0 products inside the cart, read the semantic hint
        hint: model.totalCartQuantity > 0
            ? 'Swipe right to hear the products.'
            : null,

        child: Column(
          children: <Widget>[
            /*** ROW-DIVIDER ***/
            Container(
              height: 1,
              color: Styles.productRowDivider,
            ),
            SizedBox(height: 32),

            /*** SHOPPING CART LIST SUBHEADING ***/
            Text(
              'Shopping Cart List:',
              style: Styles.productRowTotal,
            ),
            SizedBox(height: 6),

            /*** TOTAL PRODUCT COUNT IN CART DESCRIPTION ***/
            Text(
              '${model.totalCartQuantity} products currently added.',
              style: Styles.productTabDescription,
              // semanticsLabel: model.totalCartQuantity > 0 ? '${model.totalCartQuantity} products currently added. Swipe right to hear the products.' : null,
            ),
          ],
        ),
      ),
    );
  }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(AppStateModel model) {
    return SliverChildBuilderDelegate((context, index) {

      // to count the shopping_cart_items beginning with 0 (currently default is 4)
      final productIndex = index - 5;
      switch (index) {
        case 0:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildNameField(),
          );
        case 1:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildEmailField(),
          );
        case 2:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildLocationField(),
          );
        case 3:
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: _buildDateAndTimePicker(context),
          );
        case 4:
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
            child: _buildCartDesciptionText(context),
          );

        default:

          /*** LOAD PRODUCT ***/
          // When the number of loaded products in the SliverChildBuilderDelegate are smaller then number of products in the cart,
          // then load more products from the cart in the SliverChildBuilderDelegate (automatically increases the productIndex)
          if (model.productsInCart.length > productIndex) {
            return ShoppingCartItem(
              index: index,
              product: model.getProductById(model.productsInCart.keys.toList()[productIndex]),
              quantity: model.productsInCart.values.toList()[productIndex], // used in '${formatter.format(quantity * product.price)}'
              lastItem: productIndex == model.productsInCart.length - 1,
              formatter: _currencyFormat,
            );
          }

          /*** DISPLAY SHIPPING, TAX AND TOTAL ***/
          // When all products are loaded and the cart was not empty before
          // Display the Shipping, Taxes and Total cost
          // Why use productsInCart.keys ?
          else if (model.productsInCart.keys.length == productIndex &&
                   model.productsInCart.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    /*** DISPLAY THREE TEXTES ***/
                    children: <Widget>[
                      Text(
                        'Shipping ${_currencyFormat.format(model.shippingCost)}',
                        style: Styles.productRowItemPrice,
                        semanticsLabel: 'Shipping ' + _currencyFormat.format(model.shippingCost) + '.',
                      ),
                      const SizedBox(height: 6),

                      Text(
                        'Tax ${_currencyFormat.format(model.tax)}',
                        style: Styles.productRowItemPrice,
                        semanticsLabel: 'Tax ' + _currencyFormat.format(model.tax) + '.',
                      ),
                      const SizedBox(height: 6),

                      Text(
                        'Total  ${_currencyFormat.format(model.totalCost)}',
                        style: Styles.productRowTotal,
                        semanticsLabel: 'Total ' + _currencyFormat.format(model.totalCost) + '.',
                      ),
                      const SizedBox(height: 18),
                    ],
                  )
                ],
              ),
            );
          }
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[

            const CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),

            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                // Method that calls _buildNameField, _buildEmailField, _buildLocationField
                // and returns three Widgets inside a SliverChildBuilderDelegate
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            )

          ],
        );
      },
    );
  }
}
