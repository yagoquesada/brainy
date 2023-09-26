import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import 'package:tfg_v3/src/constants/string_assets.dart';
import 'package:tfg_v3/src/repository/authentication_repository/authentication_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    startAnimation();
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
      body: getBody(),
    );
  }

  AnimatedOpacity getBody() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1600),
      opacity: animate ? 1 : 0,
      child: const RiveAnimation.asset(tRiveBrainy2),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => animate = true);
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() => animate = false);
    Get.put(AuthenticationRepository());
  }
}
