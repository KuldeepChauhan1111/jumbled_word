import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {

  static const String lastSearchKey = "last_search";

  static Future<void> saveLastSearch(
      String input, List<String> result) async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode({
      "input": input,
      "result": result,
    });

    await prefs.setString(lastSearchKey, data);
  }

  static Future<Map<String, dynamic>?> getLastSearch() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(lastSearchKey);

    if (data == null) return null;

    return jsonDecode(data);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(lastSearchKey);
  }
}
