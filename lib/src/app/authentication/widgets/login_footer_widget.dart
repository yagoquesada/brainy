import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tfg_v3/src/app/authentication/controllers/sign_in_controller.dart';
import 'package:tfg_v3/src/app/authentication/pages/signup_screen.dart';
import 'package:tfg_v3/src/app/authentication/widgets/auth_supplier_button.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/assets_strings.dart';
import '../../../core/presentation/utils/constants/colors.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Column(
      children: [
        Text(
          YTexts.continueWith,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        YHelperFunctions.addVerticalSpace(40),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AuthSupplierButton(
              icon: YAssets.googleIcon,
              isLoading: controller.isGoogleLoading.value ? true : false,
              onPress: () => controller.googleSignIn(),
              /* onPress: () => controller.isFacebookLoading.value || controller.isLoading.value
                  ? () {}
                  : controller.isGoogleLoading.value
                      ? () {}
                      : () => controller.googleSignIn(), */
              background: Colors.blue[100]!,
              foreground: Colors.blue[800]!,
              text: YTexts.google,
            ),
            YHelperFunctions.addVerticalSpace(20),
            AuthSupplierButton(
              icon: YAssets.facebookIcon,
              onPress: () => getSnackBar(YTexts.snap, YTexts.facebookAuthError, true),
              background: Colors.blue[800]!,
              foreground: Colors.white,
              text: YTexts.facebook,
            ),
          ],
        ),
        YHelperFunctions.addVerticalSpace(40),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: YTexts.notAMember,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextSpan(
                text: YTexts.registerNow,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: YColors.primary),

                recognizer: TapGestureRecognizer()..onTap = () => YHelperFunctions.navigateToScreenAndReplace(context, const SignUpScreen()),
                // recognizer:
              ),
            ],
          ),
        ),
      ],
    );
  }
}
