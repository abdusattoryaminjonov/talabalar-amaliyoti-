import 'package:shared_preferences/shared_preferences.dart';

class TutorialCache {
  static const key = "internship_tutorial_done";

  static Future<bool> isDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> markDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }
}