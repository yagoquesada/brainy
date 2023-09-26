import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/features/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/features/profile/edit_profile/edit_profile_screen.dart';
import 'package:tfg_v3/src/features/profile/widgets/header_profile.dart';

import 'package:tfg_v3/src/common_widgets/tiles/menu_tiles.dart';
import 'package:tfg_v3/src/features/settings/about_us/about_me_screen.dart';
import 'package:tfg_v3/src/utils/alert_dialog/custom_alert_dialog.dart';
import 'package:tfg_v3/src/utils/app_bar/app_bar.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final controller = Get.put(AccountController());
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: const AppBarWdg(
        title: "Profile",
        darkModeButton: false,
        closeButton: false,
        isChat: false,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: getBody(user, context, controller),
    );
  }

  Widget getBody(User user, BuildContext context, AccountController controller) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 35.0),
        child: Column(
          children: [
            const HeaderProfile(),
            addVerticalSpace(15),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                user.displayName!.toUpperCase(),
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            addVerticalSpace(5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                user.email ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            addVerticalSpace(30),
            MenuTiles(
              icon: Icons.edit_outlined,
              title: "Edit Profile",
              onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              ),
            ),
            customDivider(context),
            MenuTiles(
              icon: Icons.lock_outline_rounded,
              title: "Reset Password",
              onPress: () => showAlertDialog(context, user, controller),
            ),
            customDivider(context),
            MenuTiles(
              icon: Icons.help_outline,
              title: "About",
              onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutMeScreen(),
                ),
              ),
            ),
            customDivider(context),
            MenuTiles(
              icon: Icons.logout_outlined,
              title: "Logout",
              endIcon: false,
              onPress: () => logOutDialog(context, controller),
            ),
            customDivider(context),
          ],
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
          text: "Are you sure you want to resset your password!",
          icon: Icons.assistant_photo,
          onPress: () {
            Navigator.pop(context);
            controller.resetPassword(user.email ?? "");
          },
        );
      },
    );
  }

  logOutDialog(context, controller) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: "Log Out",
          text: "Are you sure you want to log out from this account!",
          icon: Icons.assistant_photo,
          onPress: () {
            Navigator.pop(context);
            controller.logout();
          },
        );
      },
    );
  }
}
