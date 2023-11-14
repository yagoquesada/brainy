import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tfg_v3/src/features/generators/chat_generator/chat_screen.dart';
import 'package:tfg_v3/src/features/generators/image_generator/image_generator_screen.dart';
import 'package:tfg_v3/src/features/home/brainy_header.dart';
import 'package:tfg_v3/src/features/home/history_text.dart';
import 'package:tfg_v3/src/features/home/list_chat_history.dart';
import 'package:tfg_v3/src/features/home/list_image_history.dart';
import 'package:tfg_v3/src/utils/constants/colors.dart';
import 'package:tfg_v3/src/utils/constants/enums.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';
import 'package:tfg_v3/src/common_widgets/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';

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
        title: YTexts.tBrainy.toUpperCase(),
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
                title: YTexts.tChatHistory,
                subtitle: YTexts.tAddChat,
                onPress: () {
                  _textFieldController.text = '';
                  chatDialog();
                },
              ),
              const Spacer(),
              const ListChatHistory(),
              const Spacer(),
              HistoryText(
                title: YTexts.tImageHistory,
                subtitle: YTexts.tAddImage,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImageGeneratorScreen()),
                  );
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
          title: YTexts.tNewChat,
          text: YTexts.tTitleNewChat,
          icon: Icons.chat,
          suffixIcon: Icons.text_fields,
          color: YColors.primary,
          onPress: () {
            if (_textFieldController.text.isNotEmpty) {
              String data = _textFieldController.text;

              FirebaseFirestore.instance.collection('users').doc(user.uid).collection('chats').add(
                {
                  'text': YTexts.tHello,
                  'timestamp': DateTime.now(),
                  'sender': ChatRole.assistant.name,
                  'isImage': false,
                  'chatIndex': 1,
                  'title': data,
                },
              );
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chatTitle: data),
                ),
              );
            } else {
              getSnackBar(
                YTexts.tSnap,
                YTexts.tWriteValidTitle,
                true,
              );
            }
          },
          onChanged: (p0) {},
          controller: _textFieldController,
          labelText: YTexts.tTitle,
        );
      },
    );
  }
}
