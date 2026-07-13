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
    final url = Uri.parse("$baseUrl/livello/$livello");
    final response = await http.get(url);

    print("Hai premuto GIOCA");
    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Errore nel caricamento domande");
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => Domanda.fromJson(e)).toList();
  }
}
