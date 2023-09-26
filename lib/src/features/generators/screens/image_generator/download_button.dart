import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tfg_v3/src/services/image_controller.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

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
          fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 55),
          backgroundColor: Theme.of(context).cardColor,
        ),
        onPressed: _downloaded
            ? () => getSnackBar("Oh Snap!", "You can't download the same image twice", true)
            : () async {
                if (widget.imageController.isLoading.value == false &&
                    widget.imageController.data.value.isNotEmpty) {
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
                        getSnackBar("Downloaded!", "Image downloaded to your gallery", false);
                      }
                      _downloading = false;
                    });
                  });
                  await GallerySaver.saveImage(path, albumName: "Brainy");
                } else {
                  getSnackBar("Oh Snap!", "Wait for the image to finish generating before continuing", true);
                }
              },
        child: _downloading
            ? Text(
                "$_progress%",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
              )
            : Text(
                'Download',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
              ),
      ),
    );
  }
}
