class ChatModel {
  final String msg;
  final int chatIndex;
  final String role;
  final bool isImage;

  ChatModel({
    required this.role,
    required this.msg,
    required this.chatIndex,
    required this.isImage,
  });

  /* factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json['msg'],
        chatIndex: json['chatIndex'],
        role: json['role'],
        isImage: json['isImage'],
      ); */

  static ChatModel fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json['msg'],
        chatIndex: json['chatIndex'],
        role: json['role'],
        isImage: json['isImage'],
      );

  Map<String, dynamic> toJson() => {
        'msg': msg,
        'chatIndex': chatIndex,
        'role': role,
        'isImage': isImage,
      };
}
