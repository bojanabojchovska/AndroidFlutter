import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> getJokeTypesFromApi() async {
    return await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
  }
  static Future<List<String>> getJokesForType(String type) async {
    try {
      final response = await http.get(
        Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Combine setup and punchline for display
        return data.map((joke) => "${joke['setup']} - ${joke['punchline']}").toList();
      } else {
        throw Exception('Failed to load jokes');
      }
    } catch (e) {
      print("Error fetching jokes: $e");
      rethrow;
    }
  }
  static Future<String> getRandomJoke() async {
    try {
      final response = await http.get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return "${data['setup']} - ${data['punchline']}";
      } else {
        throw Exception('Failed to load random joke');
      }
    } catch (e) {
      print("Error fetching random joke: $e");
      rethrow;
    }
  }
}

