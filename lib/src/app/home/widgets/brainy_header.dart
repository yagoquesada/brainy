import 'dart:math';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../core/presentation/utils/constants/assets_strings.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';

class BrainyHeader extends StatelessWidget {
  const BrainyHeader({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.5,
          height: height * 0.2,
          child: const RiveAnimation.asset(
            YAssets.riveHeadBrainy,
            alignment: Alignment.centerLeft,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          child: BubbleSpecialThree(
            text: randomText(),
            color: Theme.of(context).canvasColor,
            textStyle: TextStyle(
              color: Theme.of(context).unselectedWidgetColor,
              fontSize: 17,
            ),
            isSender: false,
          ),
        ),
      ],
    );
  }

  randomText() {
    var list = YTexts.listBrainy;
    final random = Random();
    var element = list[random.nextInt(list.length)];
    return element;
  }
}
