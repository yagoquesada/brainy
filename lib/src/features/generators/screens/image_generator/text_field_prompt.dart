import 'package:flutter/material.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class TextFieldPrompt extends StatelessWidget {
  const TextFieldPrompt({
    Key? key,
    required TextEditingController textEditingController,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(tPromptTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).unselectedWidgetColor)),
        addVerticalSpace(15.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          child: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusColor: tVividSkyBlue,
              hintText: tPromptHint,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
