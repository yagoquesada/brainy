// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tfg_v3/src/features/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/utils/alert_dialog/custom_alert_dialog.dart';
import 'package:tfg_v3/src/utils/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

class DeleteAccountButton extends StatefulWidget {
  const DeleteAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountButton> createState() => _DeleteAccountButtonState();
}

class _DeleteAccountButtonState extends State<DeleteAccountButton> {
  String? password;
  String? valueText;
  final user = FirebaseAuth.instance.currentUser!;
  final controller = Get.put(AccountController());

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () async {
          if (await GoogleSignIn().isSignedIn()) {
            showGoogleAlertDialog(context);
          } else {
            showAlertDialog(context);
          }
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width * 0.7, 50),
          ),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.all(
            const BorderSide(
              width: 3.5,
              color: Colors.red,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          "Delete ",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomTextFieldDialog(
          title: "Warning",
          text: "Are you sure you want to delete your account!",
          labelText: "Write your password",
          icon: Icons.assistant_photo,
          suffixIcon: Icons.lock_outline,
          color: Colors.redAccent,
          onPress: () {
            password = valueText;
            if (password?.isEmpty ?? true) {
              getSnackBar(
                "Error",
                "Password can't be empty",
                true,
              );
            }
            if (user.email?.isEmpty ?? true) {
              getSnackBar(
                "Error",
                "Problem deleting your account, please log out, and try it again",
                true,
              );
            }
            controller.deleteAccount(user.email!, password ?? "");
          },
          onChanged: (value) => setState(() => valueText = value),
          controller: _textFieldController,
        );
      },
    );
  }

  showGoogleAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Disconnect",
          text: "Are you sure you want to disconnect your Google account!",
          icon: Icons.assistant_photo,
          onPress: () => controller.disconnectGoogle(),
        );
      },
    );
  }
}
