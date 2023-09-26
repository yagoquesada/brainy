import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/constants/string_assets.dart';
import 'package:tfg_v3/src/providers/models_provider.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

import 'package:tfg_v3/src/utils/theme/theme.dart';

class AppBarWdg extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWdg({
    super.key,
    required this.title,
    required this.closeButton,
    required this.darkModeButton,
    required this.isChat,
  });

  final String title;
  final bool closeButton;
  final bool darkModeButton;
  final bool isChat;

  @override
  State<AppBarWdg> createState() => _AppBarWdgState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}

class _AppBarWdgState extends State<AppBarWdg> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 25),
      ),
      elevation: 3,
      actions: [
        if (widget.closeButton && widget.isChat) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                setState(
                  () {
                    isSelected = !isSelected;
                    if (isSelected) {
                      modelsProvider.setMemoryEnabled(true);
                      getSnackBar(
                        "Memory enabled",
                        "Now Brainy is going to remember past messages.",
                        false,
                      );
                    } else {
                      modelsProvider.setMemoryEnabled(false);
                      getSnackBar(
                        "Memory disabled",
                        "Brainy is not gonna remember what you said in the past. ",
                        false,
                      );
                    }
                  },
                );
              },
              style: OutlinedButton.styleFrom(side: const BorderSide(style: BorderStyle.none)),
              child: ImageIcon(
                const AssetImage(tLogoBrain),
                size: 30,
                color: isSelected ? tVividSkyBlue : Theme.of(context).unselectedWidgetColor,
              ),
            ),
          ),
        ] else if (widget.darkModeButton) ...[
          IconButton(
            onPressed: pressedLightDarkMode,
            icon: Icon(
              iconBool ? iconDark : iconLight,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
        ] else ...[
          const SizedBox.shrink(),
        ],
      ],
      leading: widget.closeButton
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close_outlined,
                color: Theme.of(context).unselectedWidgetColor,
              ),
            )
          : null,
    );
  }

  void pressedLightDarkMode() {
    setState(() {
      iconBool = !iconBool;
      isLightTheme.add(iconBool);
    });
  }
}
