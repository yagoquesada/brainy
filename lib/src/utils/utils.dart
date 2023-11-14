import 'package:flutter/material.dart';

import 'package:tfg_v3/src/utils/constants/colors.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget customDivider(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 40),
    child: Divider(
      color: YColors.tShadowColorDark,
      thickness: 1,
    ),
  );
}
