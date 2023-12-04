import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/app/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/app/profile/edit_profile/delete_account_button.dart';
import 'package:tfg_v3/src/app/profile/edit_profile/reset_password_button.dart';
import 'package:tfg_v3/src/app/profile/widgets/text_field_edit_profile.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

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
        title: YTexts.editProfile,
        darkModeButton: false,
        closeButton: true,
        isChat: false,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: YHelperFunctions.screenHeight() - 100,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(YTexts.editName.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              YHelperFunctions.addVerticalSpace(20),
              TextFieldEditProfile(
                hintText: user.displayName,
                prefixIcon: Icons.person_outline_outlined,
                controller: nameController,
                onPress: () {
                  if (nameController.text.isEmpty) {
                    getSnackBar(YTexts.error, YTexts.validName, true);
                  } else if (nameController.text.length < 2) {
                    getSnackBar(YTexts.error, YTexts.longerName, true);
                  } else if (nameController.text.length > 35) {
                    getSnackBar(YTexts.error, YTexts.shorterName, true);
                  } else {
                    controller.updateName(nameController.text.trim());
                  }
                },
              ),
              YHelperFunctions.addVerticalSpace(25),
              Text(YTexts.resetPassword.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              YHelperFunctions.addVerticalSpace(20),
              const ResetPasswordButton(),
              YHelperFunctions.addVerticalSpace(25),
              Text(YTexts.deleteAccount.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              YHelperFunctions.addVerticalSpace(20),
              const DeleteAccountButton(),
              const Spacer(flex: 8),
            ],
          ),
        ),
      ),
    );
  }
}
