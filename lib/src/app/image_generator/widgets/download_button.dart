import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tfg_v3/src/app/image_generator/controllers/image_controller.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    Key? key,
    required this.imageController,
    required this.imagePrompt,
  }) : super(key: key);

  final ImageController imageController;
  final String imagePrompt;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _downloaded = false;
  bool _downloading = false;
  String _progress = '0';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(YHelperFunctions.screenWidth() * 0.4, 55),
          backgroundColor: Theme.of(context).cardColor,
        ),
        onPressed: _downloaded
            ? () => getSnackBar(
                  YTexts.snap,
                  YTexts.errorDownloadTwice,
                  true,
                )
            : () async {
                if (widget.imageController.isLoading.value == false && widget.imageController.data.value.isNotEmpty) {
                  setState(() {
                    _downloading = true;
                  });

                  String url = widget.imageController.data.value;

                  Directory tempDir = await getTemporaryDirectory();
                  String path = '${tempDir.path}/image.jpg';

                  Dio dio = Dio();

                  await dio.download(
                    url,
                    path,
                    onReceiveProgress: (rcv, total) {
                      setState(() {
                        _progress = ((rcv / total) * 100).toStringAsFixed(0);
                      });

                      if (_progress == '100') {
                        setState(() {
                          _downloaded = true;
                        });
                      } else if (double.parse(_progress) < 100) {}
                    },
                    deleteOnError: true,
                  ).then((_) {
                    setState(() {
                      if (_progress == '100') {
                        _downloaded = true;
                        getSnackBar(
                          YTexts.success,
                          YTexts.downloadedToGallery,
                          false,
                        );
                      }
                      _downloading = false;
                    });
                  });
                  await GallerySaver.saveImage(
                    path,
                    albumName: YTexts.brainy,
                  );
                } else {
                  getSnackBar(
                    YTexts.snap,
                    YTexts.waitToFinish,
                    true,
                  );
                }
              },
        child: _downloading
            ? Text(
                '$_progress%',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
              )
            : Text(
                YTexts.download,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
              ),
      ),
    );
  }
}
