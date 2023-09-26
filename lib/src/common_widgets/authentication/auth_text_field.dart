import 'package:flutter/material.dart';
import 'package:tfg_v3/src/constants/colors.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.inputType,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType inputType;
  final String? Function(String?) validator;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      controller: widget.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(width: 3),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(width: 2, color: tVividSkyBlue),
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        prefixIcon: Icon(widget.prefixIcon),
        prefixIconColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.focused) ? tVividSkyBlue : Colors.grey),
        hintText: widget.hintText,
        labelText: widget.hintText,
        suffixIcon: widget.hintText == "Password"
            ? IconButton(
                onPressed: () => setState(() => passToggle = !passToggle),
                icon: Icon(
                  passToggle ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                ),
              )
            : null,
        suffixIconColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.focused) ? tVividSkyBlue : Colors.grey),
        errorStyle: const TextStyle(fontSize: 16),
      ),
      obscureText: widget.hintText == "Password"
          ? passToggle
              ? true
              : false
          : false,
      style: Theme.of(context).textTheme.bodyLarge,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
    );
  }
}
