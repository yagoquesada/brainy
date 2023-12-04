import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tfg_v3/src/app/menu/pages/menu_screen.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class FullImage extends StatefulWidget {
  const FullImage({super.key, required this.url});

  final String url;

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  bool _downloading = false;

  String _progress = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          imageContainer(),
          YHelperFunctions.addVerticalSpace(30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              continueButton(context),
              YHelperFunctions.addHorizontalSpace(10),
              downloadButton(context),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Center imageContainer() {
    return Center(
      child: Container(
        width: YHelperFunctions.screenWidth() * 0.9,
        height: YHelperFunctions.screenWidth() * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(widget.url),
          ),
        ),
      ),
    );
  }

  ElevatedButton continueButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(YHelperFunctions.screenWidth() * 0.4, 55),
        backgroundColor: Theme.of(context).cardColor,
      ),
      onPressed: () {
        YHelperFunctions.navigateToScreen(context, const MenuScreen());
      },
      child: Text(
        YTexts.ccontinue,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  ElevatedButton downloadButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(YHelperFunctions.screenWidth() * 0.4, 55),
        backgroundColor: Theme.of(context).cardColor,
      ),
      onPressed: () async {
        setState(() {
          _downloading = true;
        });

        Directory tempDir = await getTemporaryDirectory();
        String path = '${tempDir.path}/image.jpg';

        Dio dio = Dio();

        await dio.download(
          widget.url,
          path,
          onReceiveProgress: (rcv, total) {
            setState(() {
              _progress = ((rcv / total) * 100).toStringAsFixed(0);
            });
          },
          deleteOnError: true,
        ).then((_) {
          setState(() {
            if (_progress == '100') {
              getSnackBar(
                YTexts.success,
                YTexts.downloadedToGallery,
                false,
              );
            }
            _downloading = false;
          });
        });
        await GallerySaver.saveImage(path, albumName: YTexts.brainy);
      },
      child: _downloading
          ? Text(
              _progress,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
            )
          : Text(
              YTexts.download,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
            ),
    );
  }
}
