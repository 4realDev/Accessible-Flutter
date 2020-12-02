import 'package:cupertino_store/language_adapted_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:flutter_native_text_input/flutter_native_text_input.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'layout/shopping_cart_item.dart';
import 'styles.dart';
import 'package:intl/intl.dart' as numberFormatLib;

const double _kDateTimePickerHeight = 216; // height of the DateTimePicker

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();

  // Currency formatter - used in calculations
  final _currencyFormat = numberFormatLib.NumberFormat.currency(symbol: '\$');

  TextEditingController _controllerName = new TextEditingController();
  FocusNode _focusNodeName = new FocusNode();

  TextEditingController _controllerEmail = new TextEditingController();
  FocusNode _focusNodeEmail = new FocusNode();

  TextEditingController _controllerLocation = new TextEditingController();
  FocusNode _focusNodeLocation = new FocusNode();

  Widget _buildCustomNameField() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[

            ExcludeSemantics(
              child: /*** ICON ***/
                  const Icon(
                CupertinoIcons.person_solid,
                color: CupertinoColors.lightBackgroundGray,
                size: 28,
              ),
            ),

            Expanded(
              child: Semantics(
                child: Platform.isIOS

                ? NativeTextInput(
                    placeholder: 'Name',
                    keyboardType: KeyboardType.defaultType,
                    textContentType: TextContentType.name,
                    controller: _controllerName,
                    focusNode: _focusNodeName,
                    onChanged: (newName) {
                      setState(() {
                        name = newName;
                      });
                    }
                  )

                : CupertinoTextField(
                    placeholder: 'Name',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,
                    decoration: BoxDecoration(border: null),
                    controller: _controllerName,
                    focusNode: _focusNodeName,
                    onChanged: (newName) {
                      setState(() {
                        name = newName;
                      });
                    },
                  ),

              ),
            ),

            MergeSemantics(
              child: GestureDetector(
                onTap: () {
                  _controllerName.clear();
                  SemanticsService.announce(LanguageAdaptedStrings.clearButtonSemanticAnnouncement, TextDirection.ltr);
                },
                child: Semantics(
                  button: true,
                  onTapHint: Platform.isIOS ? null : LanguageAdaptedStrings.clearButtonOnTapHint, // "onTapHind" DOES NOT WORK ON IOS
                  hint: Platform.isIOS ? LanguageAdaptedStrings.clearButtonHint : null, // "hint" as WORKAROUND ONLY FOR IOS

                  child: Icon(
                    CupertinoIcons.clear_thick_circled,
                    color: Styles.searchIconColor,
                    semanticLabel: LanguageAdaptedStrings.clearButtonLabel, //"Clear",
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 6),
        Container(
          height: 1,
          color: Styles.productRowDivider,
        ),
      ],
    );
  }

  Widget _buildCustomEmailField() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[

            ExcludeSemantics(
              child: /*** ICON ***/
              const Icon(
                CupertinoIcons.mail_solid,
                color: CupertinoColors.lightBackgroundGray,
                size: 28,
              ),
            ),

            Expanded(
              child: Semantics(
                child: Platform.isIOS

                ? NativeTextInput(
                  placeholder: 'Email',
                  keyboardType: KeyboardType.defaultType,
                  textContentType: TextContentType.name,
                  controller: _controllerEmail,
                  focusNode: _focusNodeEmail,
                  onChanged: (newEmail) {
                    setState(() {
                      email = newEmail;
                    });
                  }
                )

                : CupertinoTextField(
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  decoration: BoxDecoration(border: null),
                  controller: _controllerEmail,
                  focusNode: _focusNodeEmail,
                ),

              ),
            ),

            MergeSemantics(
              child: GestureDetector(
                onTap: () {
                  _controllerEmail.clear();
                  SemanticsService.announce(LanguageAdaptedStrings.clearButtonSemanticAnnouncement, TextDirection.ltr);
                },
                child: Semantics(
                  button: true,
                  onTapHint: Platform.isIOS ? null : LanguageAdaptedStrings.clearButtonOnTapHint, // "onTapHind" DOES NOT WORK ON IOS
                  hint: Platform.isIOS ? LanguageAdaptedStrings.clearButtonHint : null, // "hint" as WORKAROUND ONLY FOR IOS

                  child: Icon(
                    CupertinoIcons.clear_thick_circled,
                    color: Styles.searchIconColor,
                    semanticLabel: LanguageAdaptedStrings.clearButtonLabel, //"Clear",
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 6),
        Container(
          height: 1,
          color: Styles.productRowDivider,
        ),
      ],
    );
  }

  Widget _buildCustomLocationField() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[

            ExcludeSemantics(
              child: /*** ICON ***/
              const Icon(
                CupertinoIcons.location_solid,
                color: CupertinoColors.lightBackgroundGray,
                size: 28,
              ),
            ),

            Expanded(
              child: Semantics(
                child: Platform.isIOS

                    ? NativeTextInput(
                    placeholder: 'Location',
                    keyboardType: KeyboardType.defaultType,
                    textContentType: TextContentType.location,
                    controller: _controllerLocation,
                    focusNode: _focusNodeLocation,
                    onChanged: (newEmail) {
                      setState(() {
                        email = newEmail;
                      });
                    }
                )

                    : CupertinoTextField(
                  placeholder: 'Location',
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  decoration: BoxDecoration(border: null),
                  controller: _controllerLocation,
                  focusNode: _focusNodeLocation,
                ),

              ),
            ),

            MergeSemantics(
              child: GestureDetector(
                onTap: () {
                  _controllerLocation.clear();
                  SemanticsService.announce(LanguageAdaptedStrings.clearButtonSemanticAnnouncement, TextDirection.ltr);
                },
                child: Semantics(
                  button: true,
                  onTapHint: Platform.isIOS ? null : LanguageAdaptedStrings.clearButtonOnTapHint, // "onTapHind" DOES NOT WORK ON IOS
                  hint: Platform.isIOS ? LanguageAdaptedStrings.clearButtonHint : null, // "hint" as WORKAROUND ONLY FOR IOS

                  child: Icon(
                    CupertinoIcons.clear_thick_circled,
                    color: Styles.searchIconColor,
                    semanticLabel: LanguageAdaptedStrings.clearButtonLabel, //"Clear",
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 6),
        Container(
          height: 1,
          color: Styles.productRowDivider,
        ),
      ],
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
              children: <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28,
                ),
                SizedBox(width: 6),
                Text(
                  LanguageAdaptedStrings.deliveryTime,
                  style: Styles.deliveryTimeLabel,
                ),
              ],
            ),
            Expanded(
              child: Text(
                numberFormatLib.DateFormat.yMMMd().add_jm().format(dateTime),
                // default Time = DateTime.now()
                style: Styles.deliveryTime,
              ),
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
            ? LanguageAdaptedStrings.cartListSemanticHint
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
              LanguageAdaptedStrings.cartListHeading,
              style: Styles.productRowTotal,
            ),
            SizedBox(height: 6),

            /*** TOTAL PRODUCT COUNT IN CART DESCRIPTION ***/
            Text(
              '${model.totalCartQuantity} ${LanguageAdaptedStrings.cartListCount}',
              style: Styles.productTabDescription,
              // semanticsLabel: model.totalCartQuantity > 0 ? '${model.totalCartQuantity} products currently added. Swipe right to hear the products.' : null,
            ),
          ],
        ),
      ),
    );
  }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate((context, index) {
      // to count the shopping_cart_items beginning with 0 (currently default is 4)
      final productIndex = index - 5;
      switch (index) {
        case 0:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildCustomNameField(),
          );

        case 1:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildCustomEmailField(),
          );
        case 2:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:  _buildCustomLocationField(),
          );
        case 3:
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
              product: model.getProductById(
                  model.productsInCart.keys.toList()[productIndex]),
              quantity: model.productsInCart.values.toList()[productIndex],
              // used in '${formatter.format(quantity * product.price)}'
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
                      const SizedBox(height: 24),
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