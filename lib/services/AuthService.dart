import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/loginResponse.dart';

class AuthService {
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:8080/api/auth";
    } else {
      return "http://10.0.2.2:8080/api/auth";
    }
  }

  static Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode != 200) {
      throw Exception("Credenziali errate");
    }

    return LoginResponse.fromJson(jsonDecode(response.body));
  }

  static Future<LoginResponse> register(String username, String password) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode != 200) {
      throw Exception("Errore registrazione");
    }

    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}
