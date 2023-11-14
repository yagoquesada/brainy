import 'package:flutter/material.dart';
import 'package:tfg_v3/src/features/menu/menu_screen.dart';
import 'package:tfg_v3/src/controllers/image_controller.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';

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
          fixedSize: Size(YHelperFunctions.screenWidth() * 0.4, 55),
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
            getSnackBar(
              YTexts.tSnap,
              YTexts.tWaitToFinish,
              true,
            );
          }
        },
        child: Text(
          YTexts.tContinue,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
