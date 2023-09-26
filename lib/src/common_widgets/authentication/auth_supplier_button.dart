import 'package:flutter/material.dart';
import 'package:tfg_v3/src/common_widgets/buttons/button_loading_widget.dart';

class AuthSupplierButton extends StatelessWidget {
  const AuthSupplierButton({
    Key? key,
    required this.icon,
    required this.onPress,
    this.isLoading = false,
    required this.foreground,
    required this.background,
    required this.text,
  }) : super(key: key);

  final String icon;
  final VoidCallback onPress;
  final bool isLoading;
  final Color foreground, background;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: foreground,
          backgroundColor: background,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        icon: isLoading ? const SizedBox() : Image(image: AssetImage(icon), width: 24, height: 24),
        label: isLoading
            ? const ButtonLoadingWidget()
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: foreground, fontSize: 18),
              ),
      ),
    );
  }
}
