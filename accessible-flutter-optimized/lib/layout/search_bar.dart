import 'package:cupertino_store/language_adapted_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_text_input/flutter_native_text_input.dart';
import 'dart:io';
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
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(

          children: [
            const Icon(
              CupertinoIcons.search,
              color: Styles.searchIconColor,
            ),

            Expanded(
              child: Semantics(
                label: LanguageAdaptedStrings.searchField, //"SearchField",

                child: Platform.isIOS

                  ? NativeTextInput(
                      keyboardType: KeyboardType.defaultType,
                      textContentType: TextContentType.name,
                      controller: controller,
                      focusNode: focusNode,
                    )

                  : CupertinoTextField(
                    controller: controller,
                    focusNode: focusNode,
                    textInputAction: TextInputAction.search,
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,
                    decoration: BoxDecoration(border: null),
                    style: Styles.searchText,
                    cursorColor: Styles.searchCursorColor,
                  ),

              ),

            ),

            GestureDetector(
              onTap: () {
                controller.clear();
                SemanticsService.announce("Text cleared", TextDirection.ltr);
              },
              child: Semantics(
                button: true,
                onTapHint: LanguageAdaptedStrings.clearButtonHint, //"clear the text",

                child: Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: Styles.searchIconColor,
                  semanticLabel: LanguageAdaptedStrings.clearButtonLabel, //"Clear",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
