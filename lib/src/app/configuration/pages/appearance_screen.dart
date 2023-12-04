import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';

import '../../../core/presentation/utils/constants/assets_strings.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late PageController _pageController;
  List<String> images = [YAssets.lightMode, YAssets.darkMode];
  List<String> text = [YTexts.lightMode, YTexts.darkMode, YTexts.moreStyles];
  int activePage = 1;
  bool pressAttention = true;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
    super.initState();
  }

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
        title: YTexts.appearance,
        darkModeButton: true,
        closeButton: true,
        isChat: false,
      ),
      body: getBody(height: YHelperFunctions.screenHeight()),
    );
  }

  PageView getBody({required double height}) {
    return PageView.builder(
        itemCount: text.length,
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (page) {
          setState(
            () {
              activePage = page;
            },
          );
        },
        itemBuilder: (context, pagePosition) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YHelperFunctions.addVerticalSpace(20),
              Text(
                text[pagePosition],
                style: pagePosition == 2
                    ? Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).unselectedWidgetColor)
                    : Theme.of(context).textTheme.displayLarge!.copyWith(color: Theme.of(context).unselectedWidgetColor),
                textAlign: TextAlign.center,
              ),
              YHelperFunctions.addVerticalSpace(20),
              Container(
                margin: const EdgeInsets.all(10),
                child: pagePosition == 2
                    ? const SizedBox.shrink()
                    : Image.asset(
                        images[pagePosition],
                        height: height * 0.75,
                      ),
              ),
            ],
          );
        });
  }
}
