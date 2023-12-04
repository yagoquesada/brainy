import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:tfg_v3/src/core/presentation/common_widgets/snack_bar/snack_bars.dart';

import '../../../core/presentation/utils/constants/text_strings.dart';
import '../../../core/presentation/utils/helpers/random_id.dart';

class ImageController extends GetxController {
  final data = ''.obs;

  final isLoading = false.obs;

  Future<void> getImage({required String imageText}) async {
    try {
      isLoading.value = true;
      String baseUrl = dotenv.get('OPENAI_BASE_URL', fallback: '');
      String apiKey = dotenv.get('OPENAI_API_KEY', fallback: '');

      var response = await http.post(
        Uri.parse('$baseUrl/images/generations'),
        headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': 'application/json'},
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
          String imageUrl = '';

          String url = data.value;
          String randomId = generateRandomId();

          Directory tempDir = await getTemporaryDirectory();
          String path = '${tempDir.path}/$randomId.jpg';

          await Dio().download(url, path);

          String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child('images');
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

          FirebaseFirestore.instance.collection('users').doc(user.uid).collection('images').add(
            {
              'url': imageUrl,
              'timestamp': DateTime.now(),
            },
          );
        }
      } else {
        getSnackBar(
          YTexts.error,
          'JsonResponse ${jsonDecode(response.body)}',
          true,
        );
      }
    } on SocketException catch (e) {
      getSnackBar(
        YTexts.error,
        e.message,
        true,
      );
    } catch (error) {
      getSnackBar(
        YTexts.error,
        error.toString(),
        true,
      );
    }
  }
}
