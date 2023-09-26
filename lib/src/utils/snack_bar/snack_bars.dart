import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/generators/screens/chat_generator/text_widget.dart';
import 'package:tfg_v3/src/utils/utils.dart';

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
        addHorizontalSpace(8.0),
        TextWidget(
          label: label ?? "Error!!! Please contact us to help you solve it :)",
        ),
      ],
    ),
  );
}

// Other SnackBars
SnackBar snackBarDownloaded() {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: tLapisLazuli,
    elevation: 0,
    content: Row(
      children: [
        const Icon(
          Icons.download,
          color: Colors.white,
        ),
        addHorizontalSpace(8.0),
        const TextWidget(
          label: tDownloaded,
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
    backgroundColor: error ? Colors.red : tVividSkyBlue,
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    colorText: Colors.white,
  );
}
