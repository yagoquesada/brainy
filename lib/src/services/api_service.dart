import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:tfg_v3/src/models/chat_model.dart';
import 'package:tfg_v3/src/utils/constants/enums.dart';
import 'package:tfg_v3/src/common_widgets/snack_bar/snack_bars.dart';
import 'package:tfg_v3/src/utils/constants/text_strings.dart';

class ApiService {
  // * Send Message using ChatGPT API
  static Future<List<ChatModel>> sendMessageGPT({
    required String message,
    required String modelId,
    List<ChatModel>? chatsList,
    required String role,
  }) async {
    try {
      final memChats = List<Map<String, String>>.empty(growable: true);
      String baseUrl = dotenv.get('BASE_URL', fallback: '');
      String apiKey = dotenv.get('API_KEY', fallback: '');

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
        headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'model': modelId,
            'messages': memChats,
          },
        ),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      if (jsonResponse['error'] != null) {
        if (jsonResponse['error']['code'] == 'context_length_exceeded') {
          throw const HttpException('max_length');
        }
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];

      if (jsonResponse['choices'].length > 0) {
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['message']['content'],
            chatIndex: 1,
            role: ChatRole.assistant.name,
            isImage: false,
          ),
        );
      }
      return chatList;
    } on SocketException catch (_) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  // * Generate Image in Chat
  static Future<List<ChatModel>> getChatImage({required String imageText}) async {
    try {
      String baseUrl = dotenv.get('BASE_URL', fallback: '');
      String apiKey = dotenv.get('API_KEY', fallback: '');

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

      final data = ''.obs;
      List<ChatModel> chatList = [];

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        data.value = jsonDecode(response.body)['data'][0]['url'];
        chatList = List.generate(
          jsonResponse['data'].length,
          (index) => ChatModel(
            msg: data.value,
            chatIndex: 1,
            role: ChatRole.assistant.name,
            isImage: true,
          ),
        );
        return chatList;
      } else {
        throw HttpException(jsonDecode(response.body));
      }
    } on SocketException catch (e) {
      getSnackBar(
        YTexts.tError,
        e.message,
        true,
      );
      rethrow;
    } catch (error) {
      getSnackBar(
        YTexts.tError,
        error.toString(),
        true,
      );
      rethrow;
    }
  }

  static Future<String> getImage({required String imageText}) async {
    final isLoading = false.obs;

    try {
      isLoading.value = true;
      String baseUrl = dotenv.get('BASE_URL', fallback: '');
      String apiKey = dotenv.get('API_KEY', fallback: '');

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

      final data = ''.obs;
      String image = '';

      if (response.statusCode == 200) {
        data.value = jsonDecode(response.body)['data'][0]['url'];
        image = data.value;
        return image;
      } else {
        throw HttpException(jsonDecode(response.body));
      }
    } on SocketException catch (e) {
      getSnackBar(
        YTexts.tError,
        e.message,
        true,
      );
      rethrow;
    } catch (error) {
      getSnackBar(
        YTexts.tError,
        error.toString(),
        true,
      );
      rethrow;
    }
  }
}
