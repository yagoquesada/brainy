import 'package:flutter/material.dart';
import 'package:tfg_v3/src/constants/colors.dart';

class TilesImageHistory extends StatelessWidget {
  const TilesImageHistory({
    Key? key,
    required this.url,
    required this.onPress,
  }) : super(key: key);

  final String url;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: InkWell(
        onTap: onPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            url,
            errorBuilder: errorBuilder,
            loadingBuilder: loadingBuilder,
          ),
        ),
      ),
    );
  }

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
              "ERROR!",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingBuilder(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).dialogBackgroundColor,
      ),
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
          color: tVividSkyBlue,
        ),
      ),
    );
  }
}
