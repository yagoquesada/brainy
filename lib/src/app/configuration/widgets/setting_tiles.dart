import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tfg_v3/src/app/configuration/pages/about_me_screen.dart';
import 'package:tfg_v3/src/app/configuration/pages/appearance_screen.dart';
import 'package:tfg_v3/src/app/configuration/pages/card_form_screen.dart';
import 'package:tfg_v3/src/app/menu/widgets/menu_tiles.dart';
import 'package:tfg_v3/src/app/authentication/controllers/account_controller.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/alert_dialog/custom_alert_dialog.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class SettingTiles extends StatelessWidget {
  const SettingTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());
    return Column(
      children: [
        const Spacer(),
        YHelperFunctions.customDivider(context),
        MenuTiles(
          icon: Icons.notifications_outlined,
          title: YTexts.notifications,
          onPress: () {},
        ),
        YHelperFunctions.customDivider(context),
        MenuTiles(
          icon: Icons.payment_outlined,
          title: YTexts.subscription,
          onPress: () => YHelperFunctions.navigateToScreen(context, const CardFormScreen()),
        ),
        YHelperFunctions.customDivider(context),
        MenuTiles(
          icon: Icons.visibility_outlined,
          title: YTexts.appearance,
          onPress: () => YHelperFunctions.navigateToScreen(context, const AppearanceScreen()),
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
        const Spacer(flex: 20),
      ],
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
