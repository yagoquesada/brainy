import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:tfg_v3/src/features/authentication/login/login_screen.dart';
import 'package:tfg_v3/src/features/authentication/signup/signup_screen.dart';
import 'package:tfg_v3/src/utils/constants/assets_strings.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool animate = false;
  late Timer timer;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
      body: getBody(context),
    );
  }

  Stack getBody(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1200),
          bottom: 0,
          top: animate ? 0 : 100,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1200),
            opacity: animate ? 1 : 0,
            // SingleChildScrollView to prevent OVERFLOW error
            child: SingleChildScrollView(
              child: SizedBox(
                height: YHelperFunctions.screenHeight(),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    SizedBox(
                      height: YHelperFunctions.screenHeight() * 0.5,
                      child: const RiveAnimation.asset(YAssets.yRiveBrainy),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      YTexts.tWelcomeTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    addVerticalSpace(20),
                    SizedBox(
                      width: YHelperFunctions.screenWidth() * 0.95,
                      child: Text(
                        YTexts.tWelcomeSubtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const Spacer(flex: 1),
                    ElevatedButton(
                      onPressed: () => YHelperFunctions.navigateToScreen(context, const SignUpScreen()),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(YHelperFunctions.screenWidth() * 0.85, 55),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            YTexts.tRegisterButton,
                            style: Theme.of(context).textTheme.titleLarge!,
                          ),
                          addHorizontalSpace(10),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(20),
                    ElevatedButton(
                      onPressed: () => YHelperFunctions.navigateToScreen(context, const LoginScreen()),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).unselectedWidgetColor),
                        fixedSize: MaterialStateProperty.all(
                          Size(YHelperFunctions.screenWidth() * 0.85, 55),
                        ),
                      ),
                      child: Text(
                        YTexts.tLoginButton,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black54),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /* Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => animate = true);
  } */

  Future startAnimation() async {
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) => setState(() => animate = true));
  }
}
