import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/loginResponse.dart';

class AuthService {
  /// URL base del backend Spring Boot
  static String get baseUrl {
    // Flutter Web → deve usare localhost (Chrome e Firefox bloccano IP privati)
    if (kIsWeb) {
      return "http://localhost:8080/api/auth";
    }

    // Android/iOS emulator o dispositivo fisico in rete locale
    return "http://10.10.93.2:8080/api/auth";
  }

  /// LOGIN
  static Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode != 200) {
      // Proviamo a estrarre il messaggio di errore personalizzato inviato dal Controller Spring Boot
      try {
        final errorData = jsonDecode(response.body);
        throw errorData["error"] ?? "Errore di autenticazione";
      } catch (e) {
        if (e is String) rethrow; // Se abbiamo già lanciato la stringa corretta, propagala
        throw "Errore del server (${response.statusCode})";
      }
    }

    return LoginResponse.fromJson(jsonDecode(response.body));
  }

  /// REGISTRAZIONE
  static Future<LoginResponse> register(String username, String password) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode != 200) {
      // Proviamo a estrarre il messaggio di errore personalizzato inviato dal Controller Spring Boot
      try {
        final errorData = jsonDecode(response.body);
        throw errorData["error"] ?? "Errore di registrazione";
      } catch (e) {
        if (e is String) rethrow; // Se abbiamo già lanciato la stringa corretta, propagala
        throw "Errore del server (${response.statusCode})";
      }
    }

    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}