import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:tfg_v3/src/app/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

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
            if (context.mounted) showGoogleAlertDialog(context);
          } else {
            if (context.mounted) showAlertDialog(context);
          }
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(YHelperFunctions.screenWidth() * 0.7, 50),
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
          YTexts.delete,
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
          title: YTexts.warning,
          text: YTexts.deleteAccountText,
          labelText: YTexts.writePassword,
          icon: Icons.assistant_photo,
          suffixIcon: Icons.lock_outline,
          color: Colors.redAccent,
          onPress: () {
            password = valueText;
            if (password?.isEmpty ?? true) {
              getSnackBar(
                YTexts.error,
                YTexts.passwordEmpty,
                true,
              );
            }
            if (user.email?.isEmpty ?? true) {
              getSnackBar(
                YTexts.error,
                YTexts.problemDeletingAccount,
                true,
              );
            }
            controller.deleteAccount(user.email!, password ?? '');
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
          title: YTexts.disconnect,
          text: YTexts.disconnectText,
          icon: Icons.assistant_photo,
          onPress: () => controller.disconnectGoogle(),
        );
      },
    );
  }
}
