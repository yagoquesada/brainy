import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tfg_v3/src/app/chat_generator/models/chat_model.dart';
import 'package:tfg_v3/src/app/chat_generator/services/api_service.dart';
import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/enums.dart';
import '../../../core/presentation/utils/constants/text_strings.dart';

class ChatProvider with ChangeNotifier {
  Future<void> sendMessageAndGetAnswers({
    required String msg,
    required String chosenModelId,
    required bool isImage,
    List<ChatModel>? chatList,
    required String title,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('chats').add(
        {
          'text': msg,
          'timestamp': DateTime.now(),
          'sender': ChatRole.user.name,
          'isImage': false,
          'chatIndex': 0,
          'title': title,
        },
      );

      if (!isImage) {
        List<ChatModel> response = await ApiService.sendMessageGPT(
          message: msg,
          modelId: chosenModelId,
          chatsList: chatList,
          role: ChatRole.user.name,
        );

        for (ChatModel chatm in response) {
          FirebaseFirestore.instance.collection('users').doc(user.uid).collection('chats').add(
            {
              'text': chatm.msg,
              'timestamp': DateTime.now(),
              'sender': chatm.role,
              'isImage': false,
              'chatIndex': 1,
              'title': title,
            },
          );
        }
      } else {
        List<ChatModel> response = await ApiService.getChatImage(imageText: msg);

        for (ChatModel chatm in response) {
          String imageUrl = '';

          String url = chatm.msg;

          Directory tempDir = await getTemporaryDirectory();
          String path = '${tempDir.path}/image.jpg';

          await Dio().download(url, path);

          String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('chatImages');
          Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

          try {
            await referenceImageToUpload.putFile(File(path));
            imageUrl = await referenceImageToUpload.getDownloadURL();
          } catch (error) {
            getSnackBar(
              YTexts.error,
              error.toString(),
              true,
            );
          }

          FirebaseFirestore.instance.collection('users').doc(user.uid).collection('chats').add(
            {
              'text': imageUrl,
              'timestamp': DateTime.now(),
              'sender': chatm.role,
              'isImage': true,
              'chatIndex': 1,
              'title': title,
            },
          );
        }
      }

      notifyListeners();
    }
  }
}
