import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tfg_v3/src/app/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/app/authentication/controllers/sign_in_controller.dart';
import 'package:tfg_v3/src/app/authentication/widgets/auth_text_field.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/alert_dialog/custom_text_field_dialog.dart';

import '../../../core/presentation/utils/constants/colors.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final signInController = Get.put(SignInController());
  final accountController = Get.put(AccountController());
  //final _formKey = GlobalKey<FormState>();

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signInController.loginFormKey,
      child: Column(
        children: [
          AuthTextField(
            inputType: TextInputType.emailAddress,
            controller: signInController.email,
            hintText: YTexts.email,
            prefixIcon: Icons.person_outline_outlined,
            validator: (value) {
              return null;
            },
          ),
          YHelperFunctions.addVerticalSpace(14),
          AuthTextField(
            inputType: TextInputType.visiblePassword,
            controller: signInController.password,
            hintText: YTexts.password,
            prefixIcon: Icons.fingerprint,
            validator: (value) {
              return null;
            },
          ),
          YHelperFunctions.addVerticalSpace(10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomTextFieldDialog(
                    title: YTexts.warning,
                    text: YTexts.confirmResetPassword,
                    icon: Icons.assistant_photo,
                    onPress: () {
                      Navigator.pop(context);
                      accountController.resetPassword(_textFieldController.text);
                    },
                    suffixIcon: Icons.text_fields,
                    color: YColors.primary,
                    onChanged: (p0) {},
                    controller: _textFieldController,
                    labelText: YTexts.email,
                  );
                },
              ),
              child: const Text(
                YTexts.forgotPassword,
                style: TextStyle(color: YColors.primary),
              ),
            ),
          ),
          YHelperFunctions.addVerticalSpace(20),
          SizedBox(
            width: YHelperFunctions.screenWidth(),
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                if (!signInController.loginFormKey.currentState!.validate()) return;
                SignInController.instance.loginUser();

                signInController.email.clear();
                signInController.password.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: YColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                YTexts.login,
                style: Theme.of(context).textTheme.bodyMedium!.merge(
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
              ),
            ),
          ),
          YHelperFunctions.addVerticalSpace(30),
        ],
      ),
    );
  }
}
