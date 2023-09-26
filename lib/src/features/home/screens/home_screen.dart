import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/generators/screens/chat_generator/chat_screen.dart';
import 'package:tfg_v3/src/features/generators/screens/image_generator/image_generator_screen.dart';

import 'package:tfg_v3/src/features/home/widgets/brainy_header.dart';
import 'package:tfg_v3/src/features/home/widgets/history_text.dart';
import 'package:tfg_v3/src/features/home/widgets/list_chat_history.dart';
import 'package:tfg_v3/src/features/home/widgets/list_image_history.dart';
import 'package:tfg_v3/src/utils/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/utils/app_bar/app_bar.dart';
import 'package:tfg_v3/src/utils/utils.dart';

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
    var height = MediaQuery.of(context).size.height;

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
        title: "Brainy".toUpperCase(),
        darkModeButton: false,
        closeButton: false,
        isChat: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrainyHeader(height: height),
            HistoryText(
              title: tChatHistory,
              subtitle: tAddChat,
              onPress: TapGestureRecognizer()
                ..onTap = () {
                  _textFieldController.text = "";
                  chatDialog();
                },
            ),
            addVerticalSpace(20.0),
            const ListChatHistory(),
            addVerticalSpace(45.0),
            HistoryText(
              title: tImageHistory,
              subtitle: tAddImage,
              onPress: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImageGeneratorScreen()),
                  );
                },
            ),
            addVerticalSpace(20.0),
            const ListImageHistory(),
          ],
        ),
      ),
    );
  }

  void chatDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomTextFieldDialog(
          title: "New Chat",
          text: "Write a title for the \nnew chat",
          icon: Icons.chat,
          suffixIcon: Icons.text_fields,
          color: tVividSkyBlue,
          onPress: () {
            String data = _textFieldController.text;

            FirebaseFirestore.instance.collection('users').doc(user.uid).collection('chats').add(
              {
                'text': "Hello! It's me Brainy!",
                'timestamp': DateTime.now(),
                'sender': "assistant",
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
          },
          onChanged: (p0) {},
          controller: _textFieldController,
          labelText: "Title",
        );
      },
    );
  }
}
