import 'package:hive/hive.dart';


class ThemeService {
  static const String boxName = "themeBox";

  static Future<void> init() async {
    await Hive.openBox(boxName);
  }

  static Future<void> saveTheme(int type) async {
    final box = Hive.box(boxName);
    await box.put("theme", type);
  }

  static int getThemeMode() {
    final box = Hive.box(boxName);
    return box.get("theme", defaultValue: 0);
  }
}

