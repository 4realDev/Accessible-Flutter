import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Enter your Name',
        //border: OutlineInputBorder(),
      ),
      scrollPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      textCapitalization: TextCapitalization.words,
      autocorrect: false,

      onChanged: (newName) {
        setState(() {
          name = newName;
        });
      },
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Enter your Email',
        //border: OutlineInputBorder(),
      ),
      scrollPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,

      onChanged: (newName) {
        setState(() {
          name = newName;
        });
      },
    );
  }

  Widget _buildLocationField() {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.location_on),
        labelText: 'Enter your Location',
        //border: OutlineInputBorder(),
      ),
      scrollPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,

      onChanged: (newName) {
        setState(() {
          name = newName;
        });
      },
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
                  Icons.access_time,
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

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(AppStateModel model) {
    return SliverChildBuilderDelegate((context, index) {

      // to count the shopping_cart_items beginning with 0 (currently default is 4)
      final productIndex = index - 4;
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
                        'Shipping '
                            '${_currencyFormat.format(model.shippingCost)}',
                        style: Styles.productRowItemPrice,
                      ),
                      const SizedBox(height: 6),

                      Text(
                        'Tax ${_currencyFormat.format(model.tax)}',
                        style: Styles.productRowItemPrice,
                      ),
                      const SizedBox(height: 6),

                      Text(
                        'Total  ${_currencyFormat.format(model.totalCost)}',
                        style: Styles.productRowTotal,
                      ),

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

            /*const CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),*/

            SliverAppBar(
              floating: true,
              pinned: false,
              snap: false,
              title: Text('Shopping cart'),
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
