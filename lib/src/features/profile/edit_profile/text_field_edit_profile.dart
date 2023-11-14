import 'package:flutter/material.dart';
import 'package:tfg_v3/src/utils/constants/colors.dart';

class TextFieldEditProfile extends StatelessWidget {
  const TextFieldEditProfile({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.onPress,
    required this.controller,
  }) : super(key: key);

  final String? hintText;
  final IconData prefixIcon;
  final void Function()? onPress;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: YColors.primary),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(width: 2, color: YColors.primary),
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.focused) ? YColors.primary : Colors.grey),
        suffixIcon: IconButton(
          onPressed: onPress,
          icon: const Icon(Icons.check),
        ),
        suffixIconColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.focused) ? YColors.primary : Colors.grey),
        hintText: hintText,
        errorStyle: const TextStyle(fontSize: 16),
      ),
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
