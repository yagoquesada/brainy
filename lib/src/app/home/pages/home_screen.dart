import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tfg_v3/src/app/chat_generator/pages/chat_screen.dart';
import 'package:tfg_v3/src/app/home/widgets/brainy_header.dart';
import 'package:tfg_v3/src/app/home/widgets/history_text.dart';
import 'package:tfg_v3/src/app/home/widgets/list_chat_history.dart';
import 'package:tfg_v3/src/app/home/widgets/list_image_history.dart';
import 'package:tfg_v3/src/app/image_generator/pages/image_generator_screen.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/colors.dart';
import '../../../core/presentation/utils/constants/enums.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarWdg(
        title: YTexts.brainy.toUpperCase(),
        darkModeButton: false,
        closeButton: false,
        isChat: false,
      ),
      body: getBody(context),
    );
  }

  SingleChildScrollView getBody(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: YHelperFunctions.screenHeight(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              BrainyHeader(
                height: YHelperFunctions.screenHeight(),
                width: YHelperFunctions.screenWidth(),
              ),
              //const Spacer(),
              HistoryText(
                title: YTexts.chatHistory,
                subtitle: YTexts.addChat,
                onPress: () {
                  _textFieldController.text = '';
                  chatDialog();
                },
              ),
              const Spacer(),
              const ListChatHistory(),
              const Spacer(),
              HistoryText(
                title: YTexts.imageHistory,
                subtitle: YTexts.addImage,
                onPress: () {
                  YHelperFunctions.navigateToScreen(context, const ImageGeneratorScreen());
                },
              ),
              const Spacer(),
              const ListImageHistory(),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }

  void chatDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomTextFieldDialog(
          title: YTexts.newChat,
          text: YTexts.titleNewChat,
          icon: Icons.chat,
          suffixIcon: Icons.text_fields,
          color: YColors.primary,
          onPress: () {
            if (_textFieldController.text.isNotEmpty) {
              String data = _textFieldController.text;

              FirebaseFirestore.instance.collection('users').doc(user.uid).collection('chats').add(
                {
                  'text': YTexts.hello,
                  'timestamp': DateTime.now(),
                  'sender': ChatRole.assistant.name,
                  'isImage': false,
                  'chatIndex': 1,
                  'title': data,
                },
              );
              Navigator.pop(context);
              YHelperFunctions.navigateToScreen(context, ChatScreen(chatTitle: data));
            } else {
              getSnackBar(
                YTexts.snap,
                YTexts.writeValidTitle,
                true,
              );
            }
          },
          onChanged: (p0) {},
          controller: _textFieldController,
          labelText: YTexts.title,
        );
      },
    );
  }
}
