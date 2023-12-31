import 'package:flutter/material.dart';

import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    required this.onPress,
  });

  final String title;
  final String text;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 170,
            child: Container(
              width: YHelperFunctions.screenWidth() * 0.8,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      YHelperFunctions.addVerticalSpace(5),
                      Text(
                        text,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      YHelperFunctions.addVerticalSpace(27),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    Size(YHelperFunctions.screenWidth() * 0.25, 40),
                                  ),
                                ),
                            child: Text(YTexts.cancel, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          ElevatedButton(
                            onPressed: onPress,
                            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.redAccent,
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                    Size(YHelperFunctions.screenWidth() * 0.25, 40),
                                  ),
                                ),
                            child: Text(YTexts.okey, style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              YHelperFunctions.screenWidth() < 420 && YHelperFunctions.screenWidth() > 350
                  ? Positioned(
                      top: -60,
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: 60,
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
