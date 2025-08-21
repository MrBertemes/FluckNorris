import 'dart:convert';

import 'package:http/http.dart' as http;

class JokesRespository {
  final String url = "https://api.chucknorris.io/jokes";

  Future<List<String>> getCategories() async {
    try {
      final uri = Uri.parse("$url/categories");
      final response = await http.get(uri);
      final decoded = jsonDecode(response.body) as List;
      return List.generate(decoded.length, (i) => decoded[i]);
    } on Exception {
      rethrow;
    }
  }
}
