import 'package:get/get.dart';
import 'package:tap/services/app_color/theme_service.dart';

class ThemeController extends GetxController {
  RxInt themeMode = 0.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value = ThemeService.getThemeMode();
  }

  void toggleTheme() {
    themeMode.value = themeMode.value == 0 ? 1 : 0;
    ThemeService.saveTheme(themeMode.value);
  }
}
