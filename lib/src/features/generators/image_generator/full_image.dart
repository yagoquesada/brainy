import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tfg_v3/src/features/menu/menu_screen.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';
import 'package:tfg_v3/src/utils/utils.dart';

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
          Center(
            child: Container(
              width: YHelperFunctions.screenWidth() * 0.95,
              height: YHelperFunctions.screenHeight() * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.url),
                ),
              ),
            ),
          ),
          addVerticalSpace(30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(YHelperFunctions.screenWidth() * 0.4, 55),
                  backgroundColor: Theme.of(context).cardColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MenuScreen(),
                    ),
                  );
                },
                child: Text(
                  YTexts.tContinue,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                ),
              ),
              addHorizontalSpace(10),
              ElevatedButton(
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
                          YTexts.tSuccess,
                          YTexts.tDownloadedToGallery,
                          false,
                        );
                      }
                      _downloading = false;
                    });
                  });
                  await GallerySaver.saveImage(path, albumName: YTexts.tBrainy);
                },
                child: _downloading
                    ? Text(
                        _progress,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                      )
                    : Text(
                        YTexts.tDownload,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
