import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_v3/src/constants/string_assets.dart';
import 'package:tfg_v3/src/utils/app_bar/app_bar.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  late PageController _pageController;
  List<String> images = [tLightMode, tDarkMode];
  List<String> text = ["Light Mode", "Dark Mode", "More styles \n coming soon..."];
  int activePage = 1;
  bool pressAttention = true;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: const AppBarWdg(
        title: "Appearance",
        darkModeButton: true,
        closeButton: true,
        isChat: false,
      ),
      body: getBody(height: height),
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
              addVerticalSpace(20),
              Text(
                text[pagePosition],
                style: pagePosition == 2
                    ? Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white)
                    : Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              addVerticalSpace(20),
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
