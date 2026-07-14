import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/punteggioResponse.dart';

class ClassificaService {
  static String get baseUrl {
    return kIsWeb
        ? "http://localhost:8080/api/punteggi"
        : "http://10.10.93.2:8080/api/punteggi";//ex 10.0.2.2
  }

  static Future<List<PunteggioResponse>> getClassifica(String livello) async {
    final url = Uri.parse("$baseUrl/classifica/$livello");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Errore caricamento classifica");
    }

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => PunteggioResponse.fromJson(e)).toList();
  }
}
