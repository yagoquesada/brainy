import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../utils/constants/assets_strings.dart';

class BackgroundLogoBrainy extends StatelessWidget {
  const BackgroundLogoBrainy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 120,
      top: -155,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: Image.asset(
            YAssets.logoBrainy,
            height: 480,
            width: 480,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
