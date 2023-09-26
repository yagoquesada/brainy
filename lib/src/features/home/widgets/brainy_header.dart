import 'dart:math';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:tfg_v3/src/constants/string_assets.dart';
import 'package:tfg_v3/src/constants/string_text.dart';

class BrainyHeader extends StatelessWidget {
  const BrainyHeader({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SizedBox(
              height: height * 0.27,
              child: const RiveAnimation.asset(tRiveBrainy2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 30),
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
      ),
    );
  }

  randomText() {
    var list = tListBrainy;
    final random = Random();
    var element = list[random.nextInt(list.length)];
    return element;
  }
}
