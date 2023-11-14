import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_v3/src/common_widgets/decoration/background_full_brainy.dart';
import 'package:tfg_v3/src/features/configuration/about_us/about_me_text.dart';
import 'package:tfg_v3/src/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

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
        title: YTexts.tAboutMeTitle,
        darkModeButton: false,
        closeButton: true,
        isChat: false,
      ),
      body: getBody(context),
    );
  }

  Stack getBody(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        BackgroundFullBrainy(),
        AboutMeText(),
      ],
    );
  }
}
