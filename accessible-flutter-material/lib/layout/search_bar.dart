import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../styles.dart';

// Create individual component to recreate iOS style search bar
// Add supporting variables, functions, and methods

class SearchBar extends StatelessWidget {
  const SearchBar({
    // needs a FocusNode and a TextEditingController
    @required this.controller,
    @required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  labelText: 'Search',
                  //floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                ),
                controller: controller,
                focusNode: focusNode,
                //style: Styles.searchText,
                cursorColor: Styles.searchCursorColor,
                textCapitalization: TextCapitalization.words,
                autocorrect: false,
                keyboardType: TextInputType.text,
              ),
            ),
            IconButton(
              icon: Icon(Icons.clear),
              enableFeedback: true, // is not provided in CupertinoButton, FloatingActionButton
              iconSize: 24.0,
              onPressed: () {
                controller.clear();
                SemanticsService.announce("SearchBar cleared", TextDirection.ltr);
              },
            ),
          ],
        ),
      ),
    );
  }
}