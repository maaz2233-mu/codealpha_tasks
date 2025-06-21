import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveProgress(String lessonId) async {
    await _prefs.setBool(lessonId, true);
  }

  static bool isLessonCompleted(String lessonId) {
    return _prefs.getBool(lessonId) ?? false;
  }

  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}
