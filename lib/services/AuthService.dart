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

    // Android/iOS emulator → 10.0.2.2
    return "http://10.10.93.2:8080/api/auth";// ex 10.0.2.2
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
      throw Exception(
        "Errore login (${response.statusCode}): ${response.body}",
      );
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
      throw Exception(
        "Errore registrazione (${response.statusCode}): ${response.body}",
      );
    }

    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}
