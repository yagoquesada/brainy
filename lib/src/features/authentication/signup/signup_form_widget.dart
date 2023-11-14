import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/common_widgets/authentication/auth_text_field.dart';
import 'package:tfg_v3/src/utils/constants/colors.dart';
import 'package:tfg_v3/src/controllers/sign_up_controller.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class SignUpFormWidget extends StatelessWidget {
  SignUpFormWidget({Key? key}) : super(key: key);

  final controller = Get.put(SignUpController());
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          AuthTextField(
            inputType: TextInputType.name,
            controller: controller.fullName,
            hintText: YTexts.tFullName,
            prefixIcon: Icons.person_outline_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return YTexts.tValidName;
              } else if (value.length < 2) {
                return YTexts.tLongerName;
              } else if (value.length > 35) {
                return YTexts.tShorterName;
              }

              return null;
            },
          ),
          addVerticalSpace(14),
          AuthTextField(
            inputType: TextInputType.emailAddress,
            controller: controller.email,
            hintText: YTexts.tEmail,
            prefixIcon: Icons.mail,
            validator: (value) {
              if (!EmailValidator.validate(value!)) {
                return YTexts.tValidEmail;
              }
              return null;
            },
          ),
          addVerticalSpace(14),
          AuthTextField(
              inputType: TextInputType.visiblePassword,
              controller: controller.password,
              hintText: YTexts.tPassword,
              prefixIcon: Icons.fingerprint,
              validator: (value) {
                if (value != null && value.length < 6) {
                  return YTexts.tLongerPassword;
                }
                return null;
              }),
          addVerticalSpace(32),
          SizedBox(
            width: YHelperFunctions.screenWidth(),
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                final isValid = controller.registerFormKey.currentState!.validate();
                if (!isValid) return;

                SignUpController.instance.registerUser();

                controller.fullName.clear();
                controller.email.clear();
                controller.password.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: YColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                YTexts.tRegister,
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
        ],
      ),
    );
  }

  Future signUp() async {
    final isValid = controller.registerFormKey.currentState!.validate();
    if (!isValid) return;

    try {
      SignUpController.instance.registerUser();
    } on FirebaseException catch (e) {
      snackBarError(e.message);
    }

    controller.email.clear();
    controller.password.clear();
  }
}
