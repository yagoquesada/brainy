import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:tfg_v3/src/constants/string_assets.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/authentication/screens/login/login_screen.dart';
import 'package:tfg_v3/src/features/authentication/screens/signup/signup_screen.dart';
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
    var height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                  child: Column(
                    children: [
                      addVerticalSpace(20),
                      SizedBox(
                        height: height * 0.5,
                        child: const RiveAnimation.asset(tRiveBrainy),
                      ),
                      addVerticalSpace(20),
                      Text(
                        tWelcomeTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      addVerticalSpace(20),
                      Text(
                        tWelcomeSubtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      addVerticalSpace(50),
                      ElevatedButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const SignUpScreen(),
                          ),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            Size(
                              MediaQuery.of(context).size.width * 0.85,
                              55,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tRegisterButton,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => const LoginScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          fixedSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.85, 55),
                          ),
                        ),
                        child: Text(
                          tLoginButton,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
