import 'package:flutter/material.dart';

import 'package:tfg_v3/src/services/image_controller.dart';
import 'package:tfg_v3/src/features/generators/screens/image_generator/image_screen.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key? key,
    required this.imageController,
    required TextEditingController textEditingController,
    required String style,
    required String color,
  })  : _textEditingController = textEditingController,
        _style = style,
        _color = color,
        super(key: key);

  final ImageController imageController;
  final TextEditingController _textEditingController;
  final String _style;
  final String _color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(
          MediaQuery.of(context).size.width * 0.9,
          65,
        ),
      ),
      onPressed: () async {
        if (imageController.isLoading.value == false) {
          String imagePrompt = _textEditingController.text.trim() + _style + _color;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageScreen(
                imageController: imageController,
                imagePrompt: _textEditingController.text.trim(),
                style: _style,
                color: _color,
              ),
            ),
          );

          await imageController.getImage(
            imageText: imagePrompt,
          );
        }
      },
      child: Text(
        "Create",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),
      ),
    );
  }
}
