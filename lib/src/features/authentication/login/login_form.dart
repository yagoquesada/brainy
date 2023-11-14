import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/common_widgets/authentication/auth_text_field.dart';
import 'package:tfg_v3/src/utils/constants/colors.dart';
import 'package:tfg_v3/src/controllers/account_controller.dart';
import 'package:tfg_v3/src/controllers/sign_in_controller.dart';
import 'package:tfg_v3/src/common_widgets/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';
import 'package:tfg_v3/src/utils/utils.dart';

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
            hintText: YTexts.tEmail,
            prefixIcon: Icons.person_outline_outlined,
            validator: (value) {
              return null;
            },
          ),
          addVerticalSpace(14),
          AuthTextField(
            inputType: TextInputType.visiblePassword,
            controller: signInController.password,
            hintText: YTexts.tPassword,
            prefixIcon: Icons.fingerprint,
            validator: (value) {
              return null;
            },
          ),
          addVerticalSpace(10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomTextFieldDialog(
                    title: YTexts.tWarning,
                    text: YTexts.tConfirmResetPassword,
                    icon: Icons.assistant_photo,
                    onPress: () {
                      Navigator.pop(context);
                      accountController.resetPassword(_textFieldController.text);
                    },
                    suffixIcon: Icons.text_fields,
                    color: YColors.primary,
                    onChanged: (p0) {},
                    controller: _textFieldController,
                    labelText: YTexts.tEmail,
                  );
                },
              ),
              child: const Text(
                YTexts.tForgotPassword,
                style: TextStyle(color: YColors.primary),
              ),
            ),
          ),
          addVerticalSpace(20),
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
                YTexts.tLogin,
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
          addVerticalSpace(30),
        ],
      ),
    );
  }
}
