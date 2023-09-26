import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:tfg_v3/src/features/menu/widgets/side_menu_tile.dart';
import 'package:tfg_v3/src/services/rive_asset.dart';
import 'package:tfg_v3/src/utils/rive/rive_utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.onMenuItemSelected});

  final void Function(RiveAsset menuItem) onMenuItemSelected;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Theme.of(context).hoverColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Functionalities".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard, stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(
                      const Duration(milliseconds: 1300),
                      () {
                        menu.input!.change(false);
                        widget.onMenuItemSelected(menu);
                      },
                    );
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
