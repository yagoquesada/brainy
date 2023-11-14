import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tfg_v3/src/common_widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:tfg_v3/src/features/generators/image_generator/full_image.dart';
import 'package:tfg_v3/src/features/generators/image_generator/image_generator_screen.dart';
import 'package:tfg_v3/src/features/home/tiles_image_history.dart';
import 'package:tfg_v3/src/utils/constants/colors.dart';

import 'package:tfg_v3/src/utils/constants/text_strings.dart';
import 'package:tfg_v3/src/utils/helpers/helper_functions.dart';
import 'package:tfg_v3/src/utils/utils.dart';

class ListImageHistory extends StatefulWidget {
  const ListImageHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<ListImageHistory> createState() => _ListImageHistoryState();
}

class _ListImageHistoryState extends State<ListImageHistory> {
  late List<QueryDocumentSnapshot> images;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 4,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseAuth.instance.authStateChanges().asyncExpand(
          (user) {
            if (user != null) {
              return FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('images')
                  .orderBy('timestamp', descending: true)
                  .snapshots();
            } else {
              return const Stream<QuerySnapshot>.empty();
            }
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: YColors.primary,
            );
          }

          images = snapshot.data!.docs;

          return images.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Text(
                        YTexts.tNoImages,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      addVerticalSpace(20),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ImageGeneratorScreen()),
                        ),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            Size(YHelperFunctions.screenWidth() * 0.5, 55),
                          ),
                        ),
                        child: Text(
                          YTexts.tStart,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final image = images[index];
                    final String url = image['url'];

                    return TilesImageHistory(
                      url: url,
                      onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FullImage(url: url)),
                      ),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: YTexts.tDelete,
                            text: YTexts.tDeleteImageText,
                            icon: Icons.delete_outlined,
                            onPress: () {
                              Navigator.pop(context);
                              final collection = FirebaseFirestore.instance.collection('users');
                              final user = FirebaseAuth.instance.currentUser!;
                              collection
                                  .doc(user.uid)
                                  .collection('images')
                                  .where('url', isEqualTo: url)
                                  .get()
                                  .then(
                                (snapshot) {
                                  for (DocumentSnapshot ds in snapshot.docs) {
                                    ds.reference.delete();
                                  }
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
