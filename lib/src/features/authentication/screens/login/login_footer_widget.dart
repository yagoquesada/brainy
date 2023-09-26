import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/common_widgets/authentication/auth_supplier_button.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/constants/string_assets.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/authentication/controllers/sign_in_controller.dart';
import 'package:tfg_v3/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:tfg_v3/src/utils/utils.dart';

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
          tContinueWith,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        addVerticalSpace(40),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AuthSupplierButton(
              icon: tGoogleIcon,
              isLoading: controller.isGoogleLoading.value ? true : false,
              onPress: () => controller.googleSignIn(),
              /* onPress: () => controller.isFacebookLoading.value || controller.isLoading.value
                  ? () {}
                  : controller.isGoogleLoading.value
                      ? () {}
                      : () => controller.googleSignIn(), */
              background: Colors.blue[100]!,
              foreground: Colors.blue[800]!,
              text: "Connect with google",
            ),
            addVerticalSpace(20),
            AuthSupplierButton(
              icon: tFacebookIcon,
              onPress: () {},
              background: Colors.blue[800]!,
              foreground: Colors.white,
              text: "Connect with Facebook",
            ),
          ],
        ),
        addVerticalSpace(40),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: tNotAMember,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextSpan(
                text: tRegisterNow,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: tVividSkyBlue),

                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const SignUpScreen(),
                        ),
                      ),
                // recognizer:
              ),
            ],
          ),
        ),
      ],
    );
  }
}
