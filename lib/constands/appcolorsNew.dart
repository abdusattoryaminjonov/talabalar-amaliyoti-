import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/app_color/theme_controller.dart';

class AppColors {
  static bool get isDark =>
      Get.find<ThemeController>().themeMode.value == 1;

  static Color get appActivePer =>
      isDark ? const Color.fromRGBO(120, 100, 200, 1.0) : const Color.fromRGBO(60, 54, 127, 1.0);

  static Color get appActiveBlue =>
      isDark ? const Color.fromRGBO(80, 140, 255, 1) : const Color.fromRGBO(25, 90, 145, 1);

  static Color get appActiveBlue1 =>
      isDark ? const Color.fromRGBO(120, 180, 255, 1.0) : const Color.fromRGBO(91, 154, 206, 1.0);

  static Color get appActiveBlueOch =>
      isDark ? const Color.fromRGBO(40, 40, 60, 1.0) : const Color.fromRGBO(179, 212, 244, 1.0);

  static Color get appActiveGreen =>
      isDark ? const Color.fromRGBO(100, 200, 120, 1.0) : const Color.fromRGBO(79, 147, 81, 1.0);

  static Color get white =>
      isDark ? const Color.fromRGBO(18, 18, 18, 1) : const Color.fromRGBO(255, 255, 255, 1);

  static Color get black =>
      isDark ? const Color.fromRGBO(240, 240, 240, 1) : const Color.fromRGBO(0, 0, 0, 1);

  static Color get black50 =>
      isDark ? const Color.fromRGBO(180, 180, 180, 1) : const Color.fromRGBO(50, 50, 50, 1);

  static Color get black05 =>
      isDark ? const Color.fromRGBO(180, 180, 180, 0.5) : const Color.fromRGBO(50, 50, 50, 0.5);

  static Color get red => const Color.fromRGBO(235, 67, 53, 1);
  static Color get purple => Colors.deepPurpleAccent;
}
