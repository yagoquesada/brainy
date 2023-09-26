import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tfg_v3/src/common_widgets/decoration/background_full_brainy.dart';
import 'package:tfg_v3/src/common_widgets/decoration/background_logo_brainy.dart';
import 'package:tfg_v3/src/features/settings/screens/setting_tiles.dart';
import 'package:tfg_v3/src/utils/app_bar/app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: const AppBarWdg(
        title: "Settings",
        darkModeButton: false,
        closeButton: false,
        isChat: false,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: getBody(context),
    );
  }

  Stack getBody(BuildContext context) {
    return const Stack(
      children: [
        BackgroundFullBrainy(),
        BackgroundLogoBrainy(),
        SettingTiles(),
      ],
    );
  }
}
