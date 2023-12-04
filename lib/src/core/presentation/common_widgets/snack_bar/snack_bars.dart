import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:tfg_v3/src/core/presentation/common_widgets/text/text_widget.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';

// Errors SnackBars
SnackBar snackBarError(String? label) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red,
    elevation: 0,
    content: Row(
      children: [
        const Icon(
          Icons.warning,
          color: Colors.white,
        ),
        YHelperFunctions.addHorizontalSpace(8.0),
        TextWidget(
          label: label ?? YTexts.error,
        ),
      ],
    ),
  );
}

// Other SnackBars
SnackBar snackBarDownloaded() {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: YColors.secondary,
    elevation: 0,
    content: Row(
      children: [
        const Icon(
          Icons.download,
          color: Colors.white,
        ),
        YHelperFunctions.addHorizontalSpace(8.0),
        const TextWidget(
          label: YTexts.downloadedToGallery,
          color: Colors.white,
        ),
      ],
    ),
  );
}

// Get SnackBars
void getSnackBar(String title, String message, bool error) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: error ? Colors.red : YColors.primary,
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    colorText: Colors.white,
  );
}
