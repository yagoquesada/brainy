import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:tfg_v3/src/constants/api_constants.dart';
import 'package:tfg_v3/src/utils/random_id/random_id.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

class ImageController extends GetxController {
  final data = ''.obs;

  final isLoading = false.obs;

  Future<void> getImage({required String imageText}) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse('$baseUrl/images/generations'),
        headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': "application/json"},
        body: jsonEncode(
          {
            'prompt': imageText,
            'n': 1,
            'size': '1024x1024',
          },
        ),
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        data.value = jsonDecode(response.body)['data'][0]['url'];

        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String imageUrl = "";

          String url = data.value;
          String randomId = generateRandomId();

          Directory tempDir = await getTemporaryDirectory();
          String path = '${tempDir.path}/$randomId.jpg';

          await Dio().download(url, path);
          //await GallerySaver.saveImage(path, albumName: "Brainy");

          String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child("images");
          Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

          try {
            await referenceImageToUpload.putFile(File(path));
            imageUrl = await referenceImageToUpload.getDownloadURL();
          } catch (error) {
            getSnackBar("Error", error.toString(), true);
          }

          FirebaseFirestore.instance.collection('users').doc(user.uid).collection('images').add(
            {
              'url': imageUrl,
              'timestamp': DateTime.now(),
            },
          );
        }
      } else {
        getSnackBar("Error", " JsonResponse ${jsonDecode(response.body)}", true);
      }
    } on SocketException catch (e) {
      getSnackBar(
        "Error",
        e.message,
        true,
      );
    } catch (error) {
      // log("error $error");
      getSnackBar(
        "Error",
        "ERROR - $error",
        true,
      );
    }
  }
}
