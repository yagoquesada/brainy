import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/features/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/features/profile/edit_profile/delete_account_button.dart';
import 'package:tfg_v3/src/features/profile/edit_profile/reset_password_button.dart';
import 'package:tfg_v3/src/features/profile/edit_profile/text_field_edit_profile.dart';
import 'package:tfg_v3/src/utils/app_bar/app_bar.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';
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
        title: "Edit Profile",
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
              Text("Edit Name".toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              addVerticalSpace(20),
              TextFieldEditProfile(
                hintText: user.displayName,
                prefixIcon: Icons.person_outline_outlined,
                controller: nameController,
                onPress: () {
                  if (nameController.text.isEmpty) {
                    getSnackBar("Error", "Please enter a valid name", true);
                  } else if (nameController.text.length < 2) {
                    getSnackBar("Error", "Enter a longer name", true);
                  } else if (nameController.text.length > 35) {
                    getSnackBar("Error", "Name is too long!", true);
                  } else {
                    controller.updateName(nameController.text.trim());
                  }
                },
              ),
              addVerticalSpace(25),
              Text("Reset password".toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              addVerticalSpace(20),
              const ResetPasswordButton(),
              addVerticalSpace(25),
              Text("Delete Account".toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              addVerticalSpace(20),
              const DeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}
