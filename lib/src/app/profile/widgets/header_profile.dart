import 'package:flutter/material.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          color: Theme.of(context).cardColor,
          child: const Icon(
            Icons.person_outline,
            size: 140,
          ),
        ),
      ),
    );
  }
}
