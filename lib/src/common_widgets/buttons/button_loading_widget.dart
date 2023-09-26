import 'package:flutter/material.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: tVividSkyBlue),
        ),
        addHorizontalSpace(10),
        const Text("Loading..."),
      ],
    );
  }
}
