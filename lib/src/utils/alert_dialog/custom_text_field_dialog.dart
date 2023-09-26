import 'package:flutter/material.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class CustomTextFieldDialog extends StatelessWidget {
  const CustomTextFieldDialog({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    required this.onPress,
    required this.onChanged,
    required this.controller,
    required this.labelText,
    required this.color,
    required this.suffixIcon,
  });

  final String title;
  final String text;
  final String labelText;
  final IconData icon;
  final IconData suffixIcon;
  final VoidCallback onPress;
  final Function(String) onChanged;
  final TextEditingController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 250,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 330,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      addVerticalSpace(5),
                      Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      addVerticalSpace(20),
                      TextField(
                        onChanged: onChanged,
                        controller: controller,
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
                          prefixIcon: Icon(suffixIcon),
                          prefixIconColor: MaterialStateColor.resolveWith((states) =>
                              states.contains(MaterialState.focused) ? tVividSkyBlue : Colors.grey),
                          labelText: labelText,
                          errorStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      addVerticalSpace(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    Size(MediaQuery.of(context).size.width * 0.25, 40),
                                  ),
                                ),
                            child: Text("Cancel", style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          ElevatedButton(
                            onPressed: onPress,
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                    color,
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    Size(MediaQuery.of(context).size.width * 0.25, 40),
                                  ),
                                ),
                            child: Text(
                              "Okey",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 60,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
