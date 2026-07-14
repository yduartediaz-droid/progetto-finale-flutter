import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const _keyUsername = 'flutter.username';
  static const _keyUserId = 'flutter.user_id';

  static Future<void> saveUser(int id, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setInt(_keyUserId, id);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_keyUsername);
    final userId = prefs.getInt(_keyUserId);
    return username != null && userId != null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
