import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tfg_v3/src/constants/string_text.dart';
import 'package:tfg_v3/src/utils/alert_dialog/custom_alert_dialog.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class TilesChatHistory extends StatefulWidget {
  const TilesChatHistory({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final String? title;
  final VoidCallback onPress;

  @override
  State<TilesChatHistory> createState() => _TilesChatHistoryState();
}

class _TilesChatHistoryState extends State<TilesChatHistory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: InkWell(
        onTap: widget.onPress,
        child: Container(
          width: 190.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).canvasColor,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).unselectedWidgetColor,
                        fontSize: 22,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                addVerticalSpace(10),
                Text(
                  tFullConversation,
                  style: Theme.of(context).textTheme.bodyLarge!.merge(
                        TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).unselectedWidgetColor,
                        ),
                      ),
                ),
                addVerticalSpace(15),
                Row(
                  children: [
                    addHorizontalSpace(120),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: "Delete",
                            text: "Are you sure you want to delete this chat?",
                            icon: Icons.delete_outlined,
                            onPress: () {
                              Navigator.pop(context);
                              final collection = FirebaseFirestore.instance.collection('users');
                              final user = FirebaseAuth.instance.currentUser!;
                              collection
                                  .doc(user.uid)
                                  .collection('chats')
                                  .where("title", isEqualTo: widget.title)
                                  .get()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.docs) {
                                  ds.reference.delete();
                                }
                              });
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete_outlined),
                      alignment: Alignment.bottomRight,
                      iconSize: 34,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
