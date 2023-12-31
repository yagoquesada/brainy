import 'package:flutter/material.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';

class ImageScreenSubtitles extends StatelessWidget {
  const ImageScreenSubtitles({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(YTexts.optional, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey)),
      ],
    );
  }
}
