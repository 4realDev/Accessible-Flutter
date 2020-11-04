import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'layout/search_bar.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';

import 'styles.dart';
import 'layout/product_list_item.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab>{

  /*@override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Search'),
        ),
      ],
    );
  }*/

  // Create individual component to recreate iOS style search bar
  // Add supporting variables, functions, and methods

  TextEditingController _controller;
  FocusNode _focusNode;
  String _searchTerms = '';

  // Initialize FocusNode and TextEditingController (with Listener)
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  // Clear FocusNode and TextEditingController on State dispose()
  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Set _searchTerm to the user typed text
  void _onTextChanged() {
    setState(() {
      _searchTerms = _controller.text;
    });
  }

  // build SearchBar
  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);  // Get AppStateModel
    final results = model.search(_searchTerms);         // Search backend data with _searchTerm
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                // Fill ProductRowItem with the results (List<Product>)
                itemBuilder: (context, index) => ProductRowItem(
                  index: index,
                  product: results[index],
                  lastItem: index == results.length - 1,
                ),
                itemCount: results.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}