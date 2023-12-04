import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tfg_v3/src/app/chat_generator/pages/chat_screen.dart';
import 'package:tfg_v3/src/app/home/widgets/tiles_chat_history.dart';

import 'package:tfg_v3/src/core/presentation/common_widgets/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/colors.dart';
import '../../../core/presentation/utils/constants/enums.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/helper_functions.dart';

class ListChatHistory extends StatefulWidget {
  const ListChatHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<ListChatHistory> createState() => _ListChatHistoryState();
}

class _ListChatHistoryState extends State<ListChatHistory> {
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Stream<List<String>> fetchDataFromFirebase() {
      if (user != null) {
        return FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('chats')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .map((snapshot) => snapshot.docs.map((doc) => doc.get('title') as String).toList());
      } else {
        return const Stream<List<String>>.empty();
      }
    }

    return Flexible(
      flex: 4,
      child: StreamBuilder<List<String>>(
        stream: fetchDataFromFirebase(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            List<String> firebaseData = snapshot.data!;
            List<String> filteredData = firebaseData.toSet().toList();

            return firebaseData.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          YTexts.emptyChatHistory,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.grey),
                        ),
                        YHelperFunctions.addVerticalSpace(20),
                        ElevatedButton(
                          onPressed: () {
                            _textFieldController.text = '';

                            chatDialog();
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(YHelperFunctions.screenWidth() * 0.5, 55),
                            ),
                          ),
                          child: Text(
                            YTexts.start,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      String title = filteredData[index];
                      return TilesChatHistory(
                        title: title,
                        onPress: () => YHelperFunctions.navigateToScreen(context, ChatScreen(chatTitle: title)),
                      );
                    },
                  );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator(
              color: YColors.primary,
            ); // Display a loading indicator while data is being fetched
          }
        },
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

              FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('chats').add(
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
