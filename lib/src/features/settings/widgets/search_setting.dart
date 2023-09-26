import 'package:flutter/material.dart';

class SearchSetting extends StatelessWidget {
  const SearchSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            IconButton(
              onPressed: () async {},
              icon: Icon(
                Icons.search,
                color: Theme.of(context).unselectedWidgetColor,
                size: 20,
              ),
            ),
            Expanded(
              child: TextField(
                // focusNode: focusNode,
                style: TextStyle(
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                // controller: textEditingController,
                onSubmitted: (value) async {},
                decoration: InputDecoration.collapsed(
                  hintText: "Search for a setting...",
                  hintStyle: TextStyle(
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
