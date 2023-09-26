import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_v3/src/features/generators/screens/image_generator/continue_button.dart';

import 'package:tfg_v3/src/services/image_controller.dart';
import 'package:tfg_v3/src/features/generators/screens/image_generator/download_button.dart';
import 'package:tfg_v3/src/features/generators/screens/image_generator/image_generated.dart';
import 'package:tfg_v3/src/utils/app_bar/app_bar.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    super.key,
    required this.imageController,
    required this.imagePrompt,
    required this.style,
    required this.color,
  });

  final ImageController imageController;
  final String imagePrompt;
  final String style;
  final String color;

  @override
  Widget build(BuildContext context) {
    String substr = ", ";
    String substrColor = "color ";
    String substrStyle = " style";
    String replacement = "";

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    String strColor = color.replaceFirst(substr, replacement);
    strColor = strColor.replaceFirst(substrColor, replacement);

    String strStyle = style.replaceFirst(substr, replacement);
    strStyle = strStyle.replaceFirst(substrStyle, replacement);

    return Scaffold(
      appBar: const AppBarWdg(
        title: "Image Ready",
        darkModeButton: false,
        closeButton: false,
        isChat: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageGenerated(imageController: imageController),
              addVerticalSpace(25.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                child: RichText(
                  text: TextSpan(
                    text: "Prompt used to create the art 📄: ",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 22),
                    children: [
                      TextSpan(
                        text: "\n$imagePrompt",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).shadowColor,
                            ),
                      ),
                      TextSpan(
                        text: "\nStyle applied 🪄: ",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 22),
                      ),
                      TextSpan(
                        text: "\n$strStyle",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).shadowColor,
                            ),
                      ),
                      TextSpan(
                        text: "\nColor used 🎨: ",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 22),
                      ),
                      TextSpan(
                        text: "\n$strColor",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).shadowColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ContinueButton(imageController: imageController),
                  addHorizontalSpace(10),
                  DownloadButton(imageController: imageController, imagePrompt: imagePrompt),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
