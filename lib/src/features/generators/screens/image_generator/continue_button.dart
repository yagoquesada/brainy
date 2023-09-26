import 'package:flutter/material.dart';
import 'package:tfg_v3/src/features/menu/screens/menu_screen.dart';
import 'package:tfg_v3/src/services/image_controller.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required this.imageController,
  }) : super(key: key);

  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 55),
          backgroundColor: Theme.of(context).cardColor,
        ),
        onPressed: () {
          if (imageController.isLoading.value == false && imageController.data.value.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MenuScreen(),
              ),
            );
          } else {
            getSnackBar("Oh Snap!", "Wait for the image to finish generating before continuing", true);
          }
        },
        child: Text(
          'Continue',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
