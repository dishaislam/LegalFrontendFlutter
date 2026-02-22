import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  final String _baseUrl = kIsWeb
      ? 'http://127.0.0.1:8000/api'
      : (defaultTargetPlatform == TargetPlatform.android
          ? 'http://10.0.2.2:8000/api'
          : 'http://127.0.0.1:8000/api');
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getIdToken();
    print('ApiService: Token is ${token != null ? "PRESENT" : "MISSING"}');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<String?> createChat() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/create'),
        headers: await _getHeaders(),
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('ApiService: Chat created successfully: ${data['chat_id']}');
        return data['chat_id'];
      } else {
        print(
            'ApiService: Error creating chat: (${response.statusCode}) ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception creating chat: $e');
      return null;
    }
  }

  Future<String?> sendMessage(String chatId, String query) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/send'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'chat_id': chatId,
          'query': query,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['answer'];
      } else {
        print('Error sending message: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception sending message: $e');
      return null;
    }
  }

  Future<List<dynamic>> getChatHistory(String chatId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/chat/$chatId/history'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['messages'] ?? [];
      } else {
        print('Error getting chat history: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception getting chat history: $e');
      return [];
    }
  }

  Future<List<dynamic>> listUserChats() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user/chats'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['chats'] ?? [];
      } else {
        print('Error listing user chats: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception listing user chats: $e');
      return [];
    }
  }
}
