import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tfg_v3/src/app/configuration/widgets/setting_tiles.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/decoration/background_full_brainy.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/decoration/background_logo_brainy.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

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
        title: YTexts.settings,
        darkModeButton: false,
        closeButton: false,
        isChat: false,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: getBody(context),
    );
  }

  Stack getBody(BuildContext context) {
    return Stack(
      children: [
        YHelperFunctions.screenWidth() < 420.0 ? const BackgroundFullBrainy() : const SizedBox.shrink(),
        YHelperFunctions.screenWidth() < 420.0 ? const BackgroundLogoBrainy() : const SizedBox.shrink(),
        const SettingTiles(),
      ],
    );
  }
}
