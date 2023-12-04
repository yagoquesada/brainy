import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.onPress,
  }) : super(key: key);

  final String name;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: onPress,
          ),
        ),
        Container(
          width: 6,
          color: Colors.transparent,
        )
      ],
    );
  }
}
