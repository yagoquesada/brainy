import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/features/generators/screens/chat_generator/chat_screen.dart';
import 'package:tfg_v3/src/features/home/widgets/tiles_chat_history.dart';
import 'package:tfg_v3/src/utils/alert_dialog/custom_text_field_dialog.dart';
import 'package:tfg_v3/src/utils/utils.dart';

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
      child: StreamBuilder<List<String>>(
        stream: fetchDataFromFirebase(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            List<String> firebaseData = snapshot.data!;
            List<String> filteredData = firebaseData.toSet().toList();

            return firebaseData.isEmpty
                ? Flexible(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tEmptyChatHistory,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.grey),
                            ),
                            addVerticalSpace(20),
                            ElevatedButton(
                              onPressed: () {
                                _textFieldController.text = "";

                                chatDialog();
                              },
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width * 0.5, 55),
                                ),
                              ),
                              child: Text(
                                tStart,
                                style:
                                    Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView.builder(
                      itemCount: filteredData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        String title = filteredData[index];
                        return TilesChatHistory(
                          title: title,
                          onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(chatTitle: title),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator(
              color: tVividSkyBlue,
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
          title: "New Chat",
          text: "Write a title for the \nnew chat",
          icon: Icons.chat,
          suffixIcon: Icons.text_fields,
          color: tVividSkyBlue,
          onPress: () {
            String data = _textFieldController.text;

            FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('chats').add(
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
