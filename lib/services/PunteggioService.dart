import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PunteggioService {
  static String get baseUrl {
    return kIsWeb
        ? "http://localhost:8080/api/punteggi"
        : "http://10.0.2.2:8080/api/punteggi";
  }

  static Future<void> salvaPunteggio({
    required int idUtente,
    required String livello,
    required int punteggioFinale,
    required int risposteCorrette,
    required int totaleDomande,
  }) async {
    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idUtente": idUtente,
        "livello": livello,
        "punteggioFinale": punteggioFinale,
        "risposteCorrette": risposteCorrette,
        "totaleDomande": totaleDomande,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Errore salvataggio punteggio: ${response.body}");
    }
  }
}
