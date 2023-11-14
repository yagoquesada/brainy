// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:tfg_v3/src/features/generators/chat_generator/chat_widget.dart';

import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/models/chat_model.dart';
import 'package:tfg_v3/src/providers/chats_provider.dart';
import 'package:tfg_v3/src/providers/models_provider.dart';
import 'package:tfg_v3/src/common_widgets/app_bar/app_bar.dart';
import 'package:tfg_v3/src/utils/constants/colors.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatTitle,
  });

  final String chatTitle;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> messages;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarWdg(
        title: widget.chatTitle,
        darkModeButton: false,
        closeButton: true,
        isChat: true,
      ),
      extendBody: true,
      body: Column(
        children: [
          addVerticalSpace(15.0),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseAuth.instance.authStateChanges().asyncExpand(
                (user) {
                  if (user != null) {
                    return FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('chats')
                        .where('title', isEqualTo: widget.chatTitle)
                        .orderBy('timestamp', descending: true)
                        .snapshots();
                  } else {
                    return const Stream<QuerySnapshot<Map<String, dynamic>>>.empty();
                  }
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(
                    color: YColors.primary,
                  );
                }

                messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final String text = message['text'];
                    final int chatIndex = message['chatIndex'];
                    final bool isImage = message['isImage'];

                    return ChatWidget(
                      msg: text,
                      chatIndex: chatIndex,
                      isImage: isImage,
                    );
                  },
                );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 30,
            ),
          ],
          addVerticalSpace(15.0),
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                height: 100,
                color: Theme.of(context).canvasColor,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: SizedBox(
                        width: YHelperFunctions.screenWidth() * 0.75,
                        child: Material(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await sendMessage(
                                      modelsProvider: modelsProvider,
                                      chatProvider: chatProvider,
                                      isImage: true,
                                      title: widget.chatTitle,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.image_outlined,
                                    color: Theme.of(context).shadowColor,
                                    size: 27,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    focusNode: _focusNode,
                                    style: TextStyle(color: Theme.of(context).unselectedWidgetColor),
                                    controller: _textEditingController,
                                    onSubmitted: (value) async {
                                      await sendMessage(
                                        modelsProvider: modelsProvider,
                                        chatProvider: chatProvider,
                                        isImage: false,
                                        title: widget.chatTitle,
                                      );
                                    },
                                    decoration: InputDecoration.collapsed(
                                      hintText: YTexts.tChatTF,
                                      hintStyle: TextStyle(color: Theme.of(context).shadowColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: YColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 8.0,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await sendMessage(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider,
                              isImage: false,
                              title: widget.chatTitle,
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: YColors.primary,
                            radius: 20,
                            child: Icon(Icons.send_rounded, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fuction to send the message
  Future<void> sendMessage({
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
    required bool isImage,
    required String title,
  }) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarError(YTexts.tMultipleMeassages));
      return;
    }
    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarError(YTexts.tTypeMeassage));
      return;
    }
    try {
      String msg = _textEditingController.text;

      setState(
        () {
          _isTyping = true;
          _textEditingController.clear();
          _focusNode.unfocus();
        },
      );

      await chatProvider.sendMessageAndGetAnswers(
        title: title,
        msg: msg,
        chosenModelId: modelsProvider.getCurrentModel,
        isImage: isImage,
        chatList: modelsProvider.hasMemory
            ? messages
                .map(
                  (e) => ChatModel(
                    role: e['sender'],
                    msg: e['text'],
                    chatIndex: e['chatIndex'],
                    isImage: e['isImage'],
                  ),
                )
                .toList()
            : null,
      );
    } catch (error) {
      var errorText = error.toString();

      if (error.toString().contains('HttpException')) {
        errorText = YTexts.tModelOverloaded;
      }

      if (error.toString().contains('max_length')) {
        errorText = YTexts.tMaximumTokens;
        modelsProvider.setMemoryEnabled(false);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        snackBarError(errorText),
      );
    } finally {
      setState(() => _isTyping = false);
    }
  }
}
