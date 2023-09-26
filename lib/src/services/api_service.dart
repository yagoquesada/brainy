import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:tfg_v3/src/constants/api_constants.dart';
import 'package:tfg_v3/src/constants/constants.dart';
import 'package:tfg_v3/src/features/generators/models/chat_model.dart';
import 'package:tfg_v3/src/utils/snack_bar/snack_bars.dart';

class ApiService {
  // * Get List of Models
  // static Future<List<ModelsModel>> getModels() async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse('$BASE_URL/models'),
  //       headers: {'Authorization': 'Bearer $API_KEY'},
  //     );

  //     Map jsonResponse = jsonDecode(response.body);

  //     if (jsonResponse['error'] != null) {
  //       // log("jsonResponse['error'] ${jsonResponse['error']["message"]}");
  //       throw HttpException(jsonResponse['error']['message']);
  //     }
  //     // log("jsonResponse $jsonResponse");
  //     List temp = [];

  //     for (var value in jsonResponse['data']) {
  //       temp.add(value);
  //       // log("temp ${value["id"]}");
  //     }
  //     return ModelsModel.modelsFromSnapshot(temp);
  //   } catch (error) {
  //     log("error $error");
  //     rethrow;
  //   }
  // }

  // * Send Message using ChatGPT API
  static Future<List<ChatModel>> sendMessageGPT({
    required String message,
    required String modelId,
    List<ChatModel>? chatsList,
    required String role,
  }) async {
    try {
      final memChats = List<Map<String, String>>.empty(growable: true);

      if (chatsList != null) {
        // add all previous chats for model to process (consumes tokens)
        memChats.addAll(
          chatsList.map(
            (chat) => {
              'role': chat.role,
              'content': chat.msg,
            },
          ),
        );
      }

      memChats.add(
        {
          'role': role,
          'content': message,
        },
      );

      var response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': "application/json"},
        body: jsonEncode(
          {
            'model': modelId,
            'messages': memChats,
          },
        ),
      );

      // Map jsonResponse = jsonDecode(response.body);
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      if (jsonResponse['error'] != null) {
        if (jsonResponse['error']['code'] == 'context_length_exceeded') {
          throw const HttpException('max_length');
        }
        throw HttpException(jsonResponse['error']["message"]);
      }

      List<ChatModel> chatList = [];

      if (jsonResponse["choices"].length > 0) {
        // log(jsonResponse["choices"].toString());
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
            role: ResponseType.assistant.name,
            isImage: false,
          ),
        );
      }
      return chatList;
    } on SocketException catch (_) {
      rethrow;
    } catch (error) {
      // log("error $error");
      rethrow;
    }
  }

  // * Generate Image in Chat
  static Future<List<ChatModel>> getChatImage({required String imageText}) async {
    try {
      //isLoading.value = true;
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

      final data = ''.obs;
      List<ChatModel> chatList = [];

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      // log(jsonResponse["data"][0]["url"]);

      if (response.statusCode == 200) {
        data.value = jsonDecode(response.body)['data'][0]['url'];
        chatList = List.generate(
          jsonResponse["data"].length,
          (index) => ChatModel(
            msg: data.value,
            chatIndex: 1,
            role: ResponseType.assistant.name,
            isImage: true,
          ),
        );
        return chatList;
      } else {
        // log(" JsonResponse ${jsonDecode(response.body)}");
        throw HttpException(jsonDecode(response.body));
      }
    } on SocketException catch (e) {
      getSnackBar(
        "Error",
        e.message,
        true,
      );
      rethrow;
    } catch (error) {
      // log("error $error");
      getSnackBar(
        "Error",
        "ERROR - $error",
        true,
      );
      rethrow;
    }
  }

  static Future<String> getImage({required String imageText}) async {
    final isLoading = false.obs;

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

      final data = ''.obs;
      String image = "";

      if (response.statusCode == 200) {
        data.value = jsonDecode(response.body)['data'][0]['url'];
        image = data.value;
        return image;
      } else {
        // " JsonResponse ${jsonDecode(response.body)}");
        throw HttpException(jsonDecode(response.body));
      }
    } on SocketException catch (e) {
      getSnackBar(
        "Error",
        e.message,
        true,
      );
      rethrow;
    } catch (error) {
      // log("error $error");
      getSnackBar(
        "Error",
        "ERROR - $error",
        true,
      );
      rethrow;
    }
  }
}
