import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/features/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/utils/alert_dialog/custom_alert_dialog.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final controller = Get.put(AccountController());

    return Center(
      child: OutlinedButton(
        onPressed: () => showAlertDialog(context, user, controller),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width * 0.7, 50),
          ),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.all(
            const BorderSide(
              width: 3.5,
              color: tVividSkyBlue,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          "Reset",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: tVividSkyBlue),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, User user, AccountController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Warning",
          text: "Are you sure you want to resset your \npassword!",
          icon: Icons.assistant_photo,
          onPress: () {
            Navigator.pop(context);
            controller.resetPassword(user.email ?? "");
          },
        );
      },
    );
  }
}
