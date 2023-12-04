import 'package:flutter/material.dart';

import '../../../core/presentation/utils/constants/colors.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

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
        Text(
          YTexts.promptTitle,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).unselectedWidgetColor),
        ),
        YHelperFunctions.addVerticalSpace(15.0),
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
              focusColor: YColors.primary,
              hintText: YTexts.promptHint,
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
