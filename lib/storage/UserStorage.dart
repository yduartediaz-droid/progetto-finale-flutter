import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static Future<void> saveUser(int id, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("idUtente", id);
    await prefs.setString("username", username);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("idUtente");
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
