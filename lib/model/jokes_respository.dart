import 'dart:convert';

import 'package:flucknorris/model/joke_model.dart';
import 'package:http/http.dart' as http;

class JokesRespository {
  final String url = "https://api.chucknorris.io/jokes";

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  Future<List<String>> getCategories() async {
    try {
      final uri = Uri.parse("$url/categories");
      final response = await http.get(uri);
      final decoded = jsonDecode(response.body) as List;
      return List.generate(decoded.length, (i) => capitalize(decoded[i]));
    } on Exception {
      rethrow;
    }
  }

  Future<JokeModel> getjokeByCategory(String category) async {
    try {
      final uri = Uri.parse("$url/random?category=$category");
      final response = await http.get(uri);
      final decoded = jsonDecode(response.body);
      final joke = JokeModel.fromJson(decoded);
      return joke;
    } on Exception {
      rethrow;
    }
  }
}
