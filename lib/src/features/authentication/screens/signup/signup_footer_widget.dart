import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/common_widgets/authentication/auth_supplier_button.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/constants/string_assets.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/authentication/controllers/sign_in_controller.dart';
import 'package:tfg_v3/src/features/authentication/screens/login/login_screen.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
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
        addVerticalSpace(30),
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
                text: tHaveAnAccount,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextSpan(
                text: tLoginHere,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: tVividSkyBlue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const LoginScreen(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
