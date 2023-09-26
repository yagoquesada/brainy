import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tfg_v3/src/features/generators/models/chat_model.dart';

class FirebaseApi {
  static Future uploadMessage(
    String role,
    int chatIndex,
    String msg,
    bool isImage,
  ) async {
    final refMessages = FirebaseFirestore.instance.collection("chats/$role/messages");

    final newMessage = ChatModel(
      role: role,
      msg: msg,
      chatIndex: chatIndex,
      isImage: isImage,
    );

    await refMessages.add(newMessage.toJson());
  }
}
