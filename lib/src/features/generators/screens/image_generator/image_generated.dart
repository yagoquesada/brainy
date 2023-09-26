import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg_v3/src/constants/colors.dart';

import 'package:tfg_v3/src/services/image_controller.dart';

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
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).cardColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(150.0),
                    child: CircularProgressIndicator(
                      color: tVividSkyBlue,
                    ),
                  ),
                ),
              )
            : imageController.data.value.isNotEmpty
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.width * 0.95,
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
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).cardColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(150.0),
                        child: CircularProgressIndicator(
                          color: tVividSkyBlue,
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
