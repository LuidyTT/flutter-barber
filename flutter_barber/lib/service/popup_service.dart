// lib/service/popup_service.dart
// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class PopupService {
  static const String _welcomePopupKey = 'welcome_popup_shown';

  static Future<bool> shouldShowWelcomePopup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasShown = prefs.getBool(_welcomePopupKey) ?? false;
      print('PopupService: Welcome popup shown before? $hasShown');
      return !hasShown;
    } catch (e) {
      print('Error checking popup status: $e');
      return true; // Mostra o popup em caso de erro
    }
  }

  static Future<void> setWelcomePopupShown() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_welcomePopupKey, true);
      print('PopupService: Welcome popup marked as shown');
    } catch (e) {
      print('Error setting popup status: $e');
    }
  }

  static Future<void> resetWelcomePopup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_welcomePopupKey, false);
      print('PopupService: Welcome popup reset');
    } catch (e) {
      print('Error resetting popup: $e');
    }
  }

  // Método para verificar o estado atual (para debug)
  static Future<void> debugPopupStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final status = prefs.getBool(_welcomePopupKey);
      print('DEBUG - Popup status: $status');
    } catch (e) {
      print('DEBUG - Error getting popup status: $e');
    }
  }

  // Método para forçar a exibição do popup (útil para testes)
  // lib/service/popup_service.dart - ADICIONE ESTE MÉTODO
  static Future<void> forceResetForTesting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_welcomePopupKey); // Remove completamente a chave
      print('PopupService: FORCE RESET - Welcome popup reset for testing');
    } catch (e) {
      print('Error force resetting popup: $e');
    }
  }
}
