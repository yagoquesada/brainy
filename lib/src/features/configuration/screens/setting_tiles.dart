import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/common_widgets/tiles/menu_tiles.dart';
import 'package:tfg_v3/src/controllers/account_controller.dart';
import 'package:tfg_v3/src/features/configuration/about_us/about_me_screen.dart';
import 'package:tfg_v3/src/features/configuration/appearance/appearance_screen.dart';
import 'package:tfg_v3/src/common_widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class SettingTiles extends StatelessWidget {
  const SettingTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());
    return Container(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          customDivider(context),
          MenuTiles(
            icon: Icons.notifications_outlined,
            title: YTexts.tNotifications,
            onPress: () {},
          ),
          customDivider(context),
          MenuTiles(
            icon: Icons.payment_outlined,
            title: YTexts.tSubscription,
            onPress: () {},
          ),
          customDivider(context),
          MenuTiles(
            icon: Icons.visibility_outlined,
            title: YTexts.tAppearance,
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppearanceScreen(),
                ),
              );
            },
          ),
          customDivider(context),
          MenuTiles(
            icon: Icons.help_outline,
            title: YTexts.tAbout,
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
            title: YTexts.tLogout,
            endIcon: false,
            onPress: () => logOutDialog(context, controller),
          ),
          customDivider(context),
        ],
      ),
    );
  }

  logOutDialog(context, controller) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: YTexts.tLogout,
          text: YTexts.tConfirmLogout,
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
