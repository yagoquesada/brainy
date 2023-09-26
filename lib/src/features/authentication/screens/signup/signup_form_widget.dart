import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/common_widgets/authentication/auth_text_field.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/features/authentication/controllers/sign_up_controller.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';
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
            hintText: "Full Name",
            prefixIcon: Icons.person_outline_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a valid name";
              } else if (value.length < 2) {
                return "Enter a longer name";
              } else if (value.length > 35) {
                return "Name is too long!";
              }

              return null;
            },
          ),
          addVerticalSpace(14),
          /* AuthTextField(
            inputType: TextInputType.number,
            controller: controller.phoneNo,
            hintText: "Phone No",
            prefixIcon: Icons.numbers,
            validator: (value) {
              String pattern =
                  r'\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}';
              RegExp regExp = RegExp(pattern);
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              } else if (!regExp.hasMatch(value) || value.length > 12) {
                return 'Please enter valid mobile number';
              }
              return null;
            },
          ), 
          addVerticalSpace(14), */
          AuthTextField(
            inputType: TextInputType.emailAddress,
            controller: controller.email,
            hintText: "Email",
            prefixIcon: Icons.mail,
            validator: (value) {
              if (!EmailValidator.validate(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          addVerticalSpace(14),
          AuthTextField(
              inputType: TextInputType.visiblePassword,
              controller: controller.password,
              hintText: "Password",
              prefixIcon: Icons.fingerprint,
              validator: (value) {
                if (value != null && value.length < 6) {
                  return "Enter min. 6 characters";
                }
                return null;
              }),
          addVerticalSpace(32),
          SizedBox(
            width: MediaQuery.of(context).size.width,
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
                backgroundColor: tVividSkyBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Register",
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
