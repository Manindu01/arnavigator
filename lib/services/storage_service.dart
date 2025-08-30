import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Simple key-value storage helper built on SharedPreferences.
class StorageService {
  StorageService._();

  static Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  // Primitives ---------------------------------------------------------------
  static Future<void> setInt(String key, int value) async {
    final p = await _prefs();
    await p.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final p = await _prefs();
    return p.getInt(key);
  }

  static Future<void> setBool(String key, bool value) async {
    final p = await _prefs();
    await p.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final p = await _prefs();
    return p.getBool(key);
  }

  static Future<void> setString(String key, String value) async {
    final p = await _prefs();
    await p.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final p = await _prefs();
    return p.getString(key);
  }

  static Future<void> setStringList(String key, List<String> values) async {
    final p = await _prefs();
    await p.setStringList(key, values);
  }

  static Future<List<String>> getStringList(String key) async {
    final p = await _prefs();
    return p.getStringList(key) ?? <String>[];
  }

  static Future<void> remove(String key) async {
    final p = await _prefs();
    await p.remove(key);
  }

  // JSON convenience --------------------------------------------------------
  static Future<void> setJson(String key, Object value) async {
    await setString(key, jsonEncode(value));
  }

  static Future<dynamic> getJson(String key) async {
    final s = await getString(key);
    if (s == null) return null;
    try {
      return jsonDecode(s);
    } catch (_) {
      return null;
    }
  }
}

// Common keys used across the app
class StorageKeys {
  static const selectedTabIndex = 'selected_tab_index';
  static const favoriteStores = 'favorite_stores'; // List<String>
  static const recentDestinations = 'recent_destinations'; // List<String>
  static const chatMessages = 'chat_messages'; // JSON string array
}
