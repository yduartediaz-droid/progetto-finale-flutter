import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/domanda.dart';

class QuizService {
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:8080/api/domande";
    } else {
      return "http://10.0.2.2:8080/api/domande";
    }
  }

  static Future<List<Domanda>> getDomandeByLivello(String livello) async {
    final url = Uri.parse("${baseUrl}/livello/$livello");
    final response = await http.get(url);

    final List list = jsonDecode(response.body);
    return list.map((e) => Domanda.fromJson(e)).toList();
  }
}
