import 'package:shared_preferences/shared_preferences.dart';

/// Helper untuk menyimpan dan mengambil data user di SharedPreferences
class UserPrefs {
  static const _keyUsername = 'user_username';
  static const _keyEmail = 'user_email';
  static const _keyRole = 'user_role';
  static const _keyPassword = 'user_password';

  static Future<void> saveUser({required String username, required String email, required String role, String? password}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyRole, role);
    if (password != null) {
      await prefs.setString(_keyPassword, password);
    }
  }

  static Future<void> updatePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  static Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_keyUsername) ?? '',
      'email': prefs.getString(_keyEmail) ?? '',
      'role': prefs.getString(_keyRole) ?? '',
      'password': prefs.getString(_keyPassword) ?? '',
    };
  }

  static Future<void> resetUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyRole);
    await prefs.remove(_keyPassword);
  }
}
