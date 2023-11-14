import 'package:flutter/material.dart';
import 'package:tfg_v3/src/features/generators/chat_generator/long_press_image.dart';
import 'package:tfg_v3/src/features/generators/chat_generator/text_widget.dart';

import 'package:tfg_v3/src/utils/constants/colors.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    required this.isImage,
  });

  final String msg;
  final int chatIndex;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 7.5,
        bottom: 7.5,
        left: chatIndex == 0 ? 0 : 20,
        right: chatIndex == 0 ? 20 : 0,
      ),
      alignment: chatIndex == 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: chatIndex == 0 ? const EdgeInsets.only(left: 45) : const EdgeInsets.only(right: 45),
        padding: const EdgeInsets.only(
          top: 17,
          bottom: 17,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: chatIndex == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
          color: chatIndex == 0 ? YColors.primary : Theme.of(context).canvasColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chatIndex == 0
                ? TextWidget(
                    // User Text
                    label: msg,
                    color: Colors.white //Theme.of(context).unselectedWidgetColor,
                    )
                : isImage
                    ? LongPressImage(
                        imageUrl: msg,
                        width: 300,
                        height: 300,
                      )
                    : Text(
                        msg.trim(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
          ],
        ),
      ),
    );
  }
}
