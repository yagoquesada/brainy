import 'package:flutter/material.dart';

class MenuTiles extends StatelessWidget {
  const MenuTiles({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPress,
    this.endIcon = true,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        style: ListTileStyle.list,
        leading: Icon(
          icon,
          size: 30,
          color: endIcon ? Theme.of(context).unselectedWidgetColor : Colors.red,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color:
                endIcon ? Theme.of(context).unselectedWidgetColor : Colors.red,
          ),
        ),
        trailing: endIcon
            ? Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Theme.of(context).unselectedWidgetColor,
              )
            : null,
        onTap: onPress,
      ),
    );
  }
}
