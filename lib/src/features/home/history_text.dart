import 'package:flutter/material.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class HistoryText extends StatelessWidget {
  const HistoryText({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 26),
        ),
        addHorizontalSpace(20),
        Flexible(
          fit: FlexFit.loose,
          child: InkWell(
            onTap: onPress,
            child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
