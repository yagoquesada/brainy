import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_v3/src/app/chat_generator/providers/memory_provider.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../utils/constants/assets_strings.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';
import '../../theme/theme.dart';

class AppBarWdg extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWdg({
    super.key,
    this.title = '',
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
    final modelsProvider = Provider.of<MemoryProvider>(context, listen: false);

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
                        YTexts.memoryEnabled,
                        YTexts.memoryEnabledDesc,
                        false,
                      );
                    } else {
                      modelsProvider.setMemoryEnabled(false);
                      getSnackBar(
                        YTexts.memoryDisabled,
                        YTexts.memoryDisabledDesc,
                        false,
                      );
                    }
                  },
                );
              },
              style: OutlinedButton.styleFrom(side: const BorderSide(style: BorderStyle.none)),
              child: ImageIcon(
                const AssetImage(YAssets.logoBrain),
                size: 30,
                color: isSelected ? YColors.primary : Theme.of(context).unselectedWidgetColor,
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
