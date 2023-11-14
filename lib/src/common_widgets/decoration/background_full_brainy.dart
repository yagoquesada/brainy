import 'package:flutter/material.dart';
import 'package:tfg_v3/src/utils/constants/assets_strings.dart';

class BackgroundFullBrainy extends StatelessWidget {
  const BackgroundFullBrainy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -50,
      top: 300,
      child: Image.asset(
        YAssets.yFullBrainy,
        height: 800,
        width: 800,
        fit: BoxFit.cover,
      ),
    );
  }
}
