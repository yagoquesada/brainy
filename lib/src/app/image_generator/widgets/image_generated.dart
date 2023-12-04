import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tfg_v3/src/app/image_generator/controllers/image_controller.dart';

import '../../../core/presentation/utils/constants/colors.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class ImageGenerated extends StatelessWidget {
  const ImageGenerated({
    Key? key,
    required this.imageController,
  }) : super(key: key);

  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return imageController.isLoading.value
            ? Center(
                child: Container(
                  width: YHelperFunctions.screenWidth() * 0.95,
                  height: YHelperFunctions.screenWidth() * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).cardColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(150.0),
                    child: CircularProgressIndicator(
                      color: YColors.primary,
                    ),
                  ),
                ),
              )
            : imageController.data.value.isNotEmpty
                ? Center(
                    child: Container(
                      width: YHelperFunctions.screenWidth() * 0.95,
                      height: YHelperFunctions.screenWidth() * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(imageController.data.value),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: YHelperFunctions.screenWidth() * 0.95,
                      height: YHelperFunctions.screenWidth() * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).cardColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(150.0),
                        child: CircularProgressIndicator(
                          color: YColors.primary,
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
