import 'package:flutter/material.dart';

import '../../utils/constants/assets_strings.dart';
import '../../utils/helpers/helper_functions.dart';

class BackgroundFullBrainy extends StatelessWidget {
  const BackgroundFullBrainy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // right: -50,
      // top: 300,
      right: YHelperFunctions.screenHeight() - 920,
      top: YHelperFunctions.screenHeight() - 570,
      child: Image.asset(
        YAssets.fullBrainy,
        height: 800,
        width: 800,
        fit: BoxFit.cover,
      ),
    );
  }
}
