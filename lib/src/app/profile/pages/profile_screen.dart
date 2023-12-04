import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/app/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/app/configuration/pages/about_me_screen.dart';
import 'package:tfg_v3/src/app/menu/widgets/menu_tiles.dart';
import 'package:tfg_v3/src/app/profile/pages/edit_profile_screen.dart';
import 'package:tfg_v3/src/app/profile/widgets/header_profile.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

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
        title: YTexts.profile,
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
      child: SizedBox(
        height: YHelperFunctions.screenHeight(),
        child: Column(
          children: [
            const Spacer(),
            const HeaderProfile(),
            YHelperFunctions.addVerticalSpace(25),
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
            YHelperFunctions.addVerticalSpace(5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                user.email ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            YHelperFunctions.addVerticalSpace(30),
            MenuTiles(
              icon: Icons.edit_outlined,
              title: YTexts.editProfile,
              onPress: () => YHelperFunctions.navigateToScreen(context, const EditProfileScreen()),
            ),
            YHelperFunctions.customDivider(context),
            MenuTiles(
              icon: Icons.lock_outline_rounded,
              title: YTexts.resetPassword,
              onPress: () => showAlertDialog(context, user, controller),
            ),
            YHelperFunctions.customDivider(context),
            MenuTiles(
              icon: Icons.help_outline,
              title: YTexts.about,
              onPress: () => YHelperFunctions.navigateToScreen(context, const AboutMeScreen()),
            ),
            YHelperFunctions.customDivider(context),
            MenuTiles(
              icon: Icons.logout_outlined,
              title: YTexts.logout,
              endIcon: false,
              onPress: () => logOutDialog(context, controller),
            ),
            YHelperFunctions.customDivider(context),
            const Spacer(flex: 8),
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
          title: YTexts.warning,
          text: YTexts.confirmResetPassword,
          icon: Icons.assistant_photo,
          onPress: () {
            Navigator.pop(context);
            controller.resetPassword(user.email ?? '');
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
          title: YTexts.logout,
          text: YTexts.confirmLogout,
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
