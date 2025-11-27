// services/user_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _firstNameKey = 'user_first_name';
  static const String _lastNameKey = 'user_last_name';
  static const String _emailKey = 'user_email';
  static const String _isLoggedInKey = 'user_is_logged_in';

  // Salvar dados do usuário após cadastro
  static Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firstNameKey, firstName);
    await prefs.setString(_lastNameKey, lastName);
    await prefs.setString(_emailKey, email);
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Recuperar dados do usuário
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'firstName': prefs.getString(_firstNameKey) ?? '',
      'lastName': prefs.getString(_lastNameKey) ?? '',
      'email': prefs.getString(_emailKey) ?? '',
    };
  }

  // Verificar se usuário está logado
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Fazer logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Limpar todos os dados (para teste)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_firstNameKey);
    await prefs.remove(_lastNameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_isLoggedInKey);
  }
}
