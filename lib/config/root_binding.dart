
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controllers/home_page_controller.dart';
import '../controllers/login_page_controller.dart';
import '../controllers/student_controllers/attendace_page_controller.dart';
import '../controllers/student_controllers/chat_page_controller.dart';
import '../controllers/student_controllers/dashboard_page_controller.dart';
import '../controllers/student_controllers/quota_page_controller.dart';
import '../controllers/student_controllers/rating_page_controller.dart';
import '../controllers/student_controllers/settings_page_controller.dart';
import '../controllers/student_controllers/task_page_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController(), fenix: true);
    Get.lazyPut(() => ChatPageController(), fenix: true);
    Get.lazyPut(() => DashboardPageController(), fenix: true);
    Get.lazyPut(() => HomePageController(), fenix: true);
    Get.lazyPut(() => TaskPageController(), fenix: true);
    Get.lazyPut(() => SettingsPageController(), fenix: true);
    Get.lazyPut(() => AttendancePageController(), fenix: true);
    Get.lazyPut(() => RatingPageController(), fenix: true);
    Get.lazyPut(() => QuotaPageController(), fenix: true);
  }
}