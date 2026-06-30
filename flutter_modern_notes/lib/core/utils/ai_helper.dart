import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final aiHelperProvider = Provider((ref) => AiHelper());

class AiHelper {
  // TODO: Provide your own Groq API key (get one at https://console.groq.com/).
  // Do NOT hard-code a real key. Pass it at build time:
  //   flutter run --dart-define=GROQ_API_KEY=your_key_here
  static const String _apiKey = String.fromEnvironment('GROQ_API_KEY');
  static const String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';
  static const String _model = 'llama-3.1-8b-instant';

  Future<String> summarize(String content) async {
    try {
      final prompt = 'Summarize the following note content concisely:\n\n$content';
      return await _generateContent(prompt);
    } catch (e) {
      return 'Error summarizing: $e';
    }
  }

  Future<String> checkGrammar(String content) async {
    try {
      final prompt = 'Fix any grammar or spelling mistakes in the following text, and return only the corrected text:\n\n$content';
      return await _generateContent(prompt);
    } catch (e) {
      return 'Error checking grammar: $e';
    }
  }

  Future<String> translate(String content, String targetLanguage) async {
    try {
      final prompt = 'Translate the following text to $targetLanguage:\n\n$content';
      return await _generateContent(prompt);
    } catch (e) {
      return 'Error translating: $e';
    }
  }

  Future<String> askGemini(String prompt) async {
    return await _generateContent(prompt);
  }

  Future<String> _generateContent(String prompt) async {
    try {
      if (_apiKey.isEmpty) {
        return 'AI Error: API Key not configured.';
      }

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        debugPrint('=== GROQ AI ERROR ===');
        debugPrint('Status: ${response.statusCode}');
        debugPrint('Body: ${response.body}');
        debugPrint('=======================');
        
        if (response.statusCode == 401) {
          return 'AI Error: Invalid API Key.';
        } else if (response.statusCode == 429) {
          return 'AI Error: Rate limit reached. Please wait.';
        } else {
          return 'AI Error: Service unavailable (${response.statusCode}).';
        }
      }
    } catch (e) {
      debugPrint('=== GROQ AI EXCEPTION ===');
      debugPrint('Error: $e');
      debugPrint('=========================');
      return 'AI Error: Network or connection issue.';
    }
  }
}
