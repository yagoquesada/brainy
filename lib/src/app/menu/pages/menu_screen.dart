import 'dart:math';

import 'package:flutter/material.dart';

import 'package:tfg_v3/src/app/configuration/pages/settings_screen.dart';
import 'package:tfg_v3/src/app/home/pages/home_screen.dart';
import 'package:tfg_v3/src/app/menu/widgets/menu_button.dart';
import 'package:tfg_v3/src/app/menu/widgets/side_menu.dart';
import 'package:tfg_v3/src/app/profile/pages/profile_screen.dart';
import 'package:tfg_v3/src/core/services/rive_asset.dart';

import '../../../core/presentation/utils/helpers/helper_functions.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  Widget body = const HomeScreen();

  bool isSideMenuClosed = true;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _setBody(RiveAsset menu) {
    switch (menu.title) {
      case 'User':
        body = const UserScreen();
        break;
      case 'Settings':
        body = const SettingsScreen();
        break;
      default:
        body = const HomeScreen();
    }
    _closeMenu();
  }

  void _closeMenu() {
    if (isSideMenuClosed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(
      () {
        isSideMenuClosed = !isSideMenuClosed;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).hoverColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: YHelperFunctions.screenHeight(),
            child: SideMenu(
              onMenuItemSelected: (menu) => _setBody(menu),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(animation.value * 20),
                  ),
                  child: body,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            top: 11,
            left: isSideMenuClosed ? 0 : 220,
            child: MenuButton(
              press: _closeMenu,
            ),
          ),
        ],
      ),
    );
  }
}
