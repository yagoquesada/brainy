import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HistoryText extends StatelessWidget {
  const HistoryText({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final TapGestureRecognizer onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 26),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
              text: subtitle,
              recognizer: onPress,
            ),
          ),
        ],
      ),
    );
  }
}
