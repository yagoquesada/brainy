import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tfg_v3/src/utils/constants/colors.dart';
import 'package:tfg_v3/src/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class LongPressImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const LongPressImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget errorBuilder(BuildContext context, Object exception, StackTrace? stackTrace) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          color: Theme.of(context).canvasColor,
          width: 190,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.broken_image_outlined,
                size: 120,
              ),
              Text(
                YTexts.tError,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onLongPress: () {
        _showPopupMenu(context);
      },
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        errorBuilder: errorBuilder,
        loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
            ? child
            : const CircularProgressIndicator.adaptive(
                backgroundColor: YColors.primary,
              ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    final popupItems = [YTexts.tFullScreen, YTexts.tDownloadImage, YTexts.tCLose];

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final RenderBox imageBox = context.findRenderObject() as RenderBox;
    final imagePosition = imageBox.localToGlobal(Offset.zero);

    final tapPosition = Offset(
      imagePosition.dx + (width / 2), // Show the menu in the middle of the image
      imagePosition.dy + (height / 2),
    );

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        overlay.size.width - tapPosition.dx,
        overlay.size.height - tapPosition.dy,
      ),
      items: popupItems.map((item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        _handlePopupSelection(context, value);
      }
    });
  }

  void _handlePopupSelection(BuildContext context, String value) {
    switch (value) {
      case YTexts.tFullScreen:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FullImageScreen(imageUrl: imageUrl)),
        );
        break;
      case YTexts.tDownloadImage:
        _downloadImage(context, imageUrl);
        break;
      case YTexts.tCLose:
        // Do nothing, the menu will close automatically
        break;
    }
  }

  void _downloadImage(BuildContext context, String imageUrl) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/image.jpg';

    Dio dio = Dio();

    await dio.download(
      imageUrl,
      path,
      onReceiveProgress: (rcv, total) {},
      deleteOnError: true,
    );

    await GallerySaver.saveImage(path, albumName: YTexts.tBrainy);
    getSnackBar(
      YTexts.tSuccess,
      YTexts.tDownloadedToGallery,
      false,
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWdg(closeButton: true, darkModeButton: false, isChat: false),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
