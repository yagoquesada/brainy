import 'package:flutter/material.dart';

import 'package:tfg_v3/src/app/image_generator/controllers/image_controller.dart';
import 'package:tfg_v3/src/app/menu/pages/menu_screen.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

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
            YHelperFunctions.navigateToScreen(context, const MenuScreen());
          } else {
            getSnackBar(
              YTexts.snap,
              YTexts.waitToFinish,
              true,
            );
          }
        },
        child: Text(
          YTexts.ccontinue,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
