import 'package:hive/hive.dart';

import '../models/login_users_model/language/language_model.dart';

class LanguageService {
  static const String boxName = "languageBox";

  static Future<void> init() async {
    await Hive.openBox<LanguageModel>(boxName);
  }

  static Future<void> saveLanguage(int type) async {
    final box = Hive.box<LanguageModel>(boxName);
    await box.put("lang", LanguageModel(type: type));
  }

  static int getLanguageType() {
    final box = Hive.box<LanguageModel>(boxName);
    final lang = box.get("lang");
    return lang?.type ?? 1; // default Uzbek
  }
}
