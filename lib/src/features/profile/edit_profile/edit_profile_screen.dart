import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/controllers/account_controller.dart';
import 'package:tfg_v3/src/features/profile/edit_profile/delete_account_button.dart';
import 'package:tfg_v3/src/features/profile/edit_profile/reset_password_button.dart';
import 'package:tfg_v3/src/features/profile/edit_profile/text_field_edit_profile.dart';
import 'package:tfg_v3/src/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final controller = Get.put(AccountController());
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: const AppBarWdg(
        title: YTexts.tEditProfile,
        darkModeButton: false,
        closeButton: true,
        isChat: false,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(YTexts.tEditName.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              addVerticalSpace(20),
              TextFieldEditProfile(
                hintText: user.displayName,
                prefixIcon: Icons.person_outline_outlined,
                controller: nameController,
                onPress: () {
                  if (nameController.text.isEmpty) {
                    getSnackBar(YTexts.tError, YTexts.tValidName, true);
                  } else if (nameController.text.length < 2) {
                    getSnackBar(YTexts.tError, YTexts.tLongerName, true);
                  } else if (nameController.text.length > 35) {
                    getSnackBar(YTexts.tError, YTexts.tShorterName, true);
                  } else {
                    controller.updateName(nameController.text.trim());
                  }
                },
              ),
              addVerticalSpace(25),
              Text(YTexts.tResetPassword.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              addVerticalSpace(20),
              const ResetPasswordButton(),
              addVerticalSpace(25),
              Text(YTexts.tDeleteAccount.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              addVerticalSpace(20),
              const DeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}
