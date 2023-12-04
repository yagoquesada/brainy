import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/core/presentation/utils/constants/colors.dart';
import 'package:tfg_v3/src/core/presentation/utils/helpers/helper_functions.dart';

import '../../../core/presentation/utils/constants/assets_strings.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWdg(
        closeButton: true,
        darkModeButton: false,
        isChat: false,
      ),
      body: Column(
        children: [
          const Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Experience the ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextSpan(
                  text: "full potential ",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: YColors.primary),
                ),
                TextSpan(
                  text: "of Brainy!!!",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
          YHelperFunctions.addVerticalSpace(20),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: MaterialStatePropertyAll(
                Size(
                  YHelperFunctions.screenWidth() * 0.9,
                  55,
                ),
              ),
            ),
            child: Text(
              YTexts.ccontinue,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
