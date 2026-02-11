import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../constands/appcolors.dart';
import '../languages/app_localizations.dart';
import '../models/login_users_model/drawe_open_key/drawer_open_key.dart';
import '../models/login_users_model/internship_model.dart';
import '../models/login_users_model/nosql_login.dart';
import '../models/login_users_model/student_model.dart';
import '../pages/splash_page/splash_page.dart';
import '../pages/student_pages/attendance_page/attendance_page.dart';
import '../pages/student_pages/chat_page/chat_main_page.dart';
import '../pages/student_pages/dashboard_page/dashboard_page.dart';
import '../pages/student_pages/login/login_page.dart';
import '../pages/student_pages/quota_page/quota_page.dart';
import '../pages/student_pages/settings_page/settings_page.dart';
import '../pages/student_pages/task_page/tasks_page.dart';
import '../services/app_color/theme_controller.dart';
import '../services/app_color/theme_service.dart';
import '../services/http_service.dart';
import '../services/language_service.dart';
import '../services/nosql_service.dart';
import '../widgets/dialogs/generic_dialog.dart';
import '../widgets/dialogs/show_inter_dialog.dart';
import '../widgets/show_message/show_message.dart';

class HomePageController extends GetxController with GetTickerProviderStateMixin  {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // final themeController = Get.find<ThemeController>();

  final httpService = HttpService();

  late Box<LoginUserData> box;
  late Box<StudentModel> studentBox;
  late Box<InternshipModel> internshipBox;
  var bottomNavIndex = 0;
  bool isLoading = false;
  bool isDrawerOpen = false;
  final drawerOpenKey = GlobalKey();
  late TutorialCoachMark tutorialCoachMark;

  late AnimationController fabAnimationController;
  late AnimationController borderRadiusAnimationController;
  late AnimationController hideBottomBarAnimationController;

  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;

  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;

  late final TickerProvider vsync;
  List<InternshipModel> internships = [];
  InternshipModel? internshipModel ;

  bool isClosed = false;
  String interName = "";
  int interId = -1;
  String interStatus = "";
  String token = "";
  String role = "";
  int selectedLang = 1;


  late final List<Widget> pages = [
    DashboardPage(),
    TasksPage(interName: interName, interId: interId),
    QuotaPage(token: token, interId: interId, interName: interName),
    ChatMainPage(),
    AttendancePage(interName: interName, interId: interId),
  ];

  void showMessage(BuildContext context, String message, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
        message,
        type: type,
        duration: const Duration(seconds: 2)
    ).show(context);
  }

  final iconList = <IconData>[
    Icons.home,
    Icons.pending_actions,
    Icons.home_work_outlined,
    Icons.chat_outlined,
  ];

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User permission: ${settings.authorizationStatus}');
  }

  Future<void> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
  }
  Future<void> subscribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic("all_users");
    print("User all_users topic ga qo'shildi");
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Background message: ${message.messageId}");
  }



  Future<void> checkAndShowTutorial(BuildContext context) async {
    final box = Hive.box<DrawerOpenKey>('drawer_tutorial');

    DrawerOpenKey data = box.get(
      'drawer',
      defaultValue: DrawerOpenKey(status: false),
    )!;

    if (!data.status) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tutorialCoachMark.show(context: context);
      });

      await box.put('drawer', DrawerOpenKey(status: true));
    }
  }

  List<TargetFocus> _createTargets(BuildContext context) {
    return [
      TargetFocus(
        identify: "drawer",
        keyTarget: drawerOpenKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Text(
                  "Choose an internship!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    ];
  }

  void initialFunction(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(context),
      colorShadow: Colors.black.withOpacity(0.7),
      hideSkip: false,
      onFinish: () {
        print("Tutorial tugadi");
      },
    );

    box = Hive.box<LoginUserData>('loginBox');

    fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    fabCurve = CurvedAnimation(
      parent: fabAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    borderRadiusCurve = CurvedAnimation(
      parent: borderRadiusAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation =
        Tween<double>(begin: 0, end: 1).animate(borderRadiusCurve);

    hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (isClosed) return;
      if (!fabAnimationController.isDismissed) return;

      fabAnimationController.forward();
      borderRadiusAnimationController.forward();
    });

    checkAndShowTutorial(context);
  }


  void changePage(int index) {
    bottomNavIndex = index;
    update();
  }

  Future<void> handleAttendance() async {
    fabAnimationController.reset();
    borderRadiusAnimationController.reset();
    fabAnimationController.forward();
    borderRadiusAnimationController.forward();
    Get.to(AttendancePage(interName: interName,interId: interId,));
      isLoading = true;
      update();

    try {

    } finally {
        isLoading = false;
        update();
    }
  }

  void loadInternship() {
    internshipModel = internshipBox.get("current_internship");

    interName = internshipModel?.name ?? "Amaliyotni tanlang";
    interStatus = internshipModel?.status ?? "";

    update();
  }


  @override
  void onClose() {
    isClosed = true;

    fabAnimationController.dispose();
    borderRadiusAnimationController.dispose();
    hideBottomBarAnimationController.dispose();

    super.onClose();
  }

  Locale getLocaleFromType(int type) {
    switch (type) {
      case 1:
        return const Locale('uz');
      case 2:
        return const Locale('ru');
      case 3:
        return const Locale('en');
      default:
        return const Locale('uz');
    }
  }

  void selectLanguage(int type,BuildContext context) async {
    selectedLang = type;
    update();

    Get.updateLocale(getLocaleFromType(type));

    await LanguageService.saveLanguage(type);

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, secondaryAnimation) =>
            SplashPage(token: token, role: role),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
          (Route<dynamic> route) => false,
    );

  }


  Widget showDrawer(BuildContext context, String token, String role) {
    final student = studentBox.get("currentStudent");

    final txt = AppLocalizations.of(context)!;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.appActiveBlue),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    student?.imageUrl ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/npuu.png", fit: BoxFit.cover);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Image.asset("assets/images/npuu.png", fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
              Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${student?.fullName.split(' ')[0] ?? ""}\n${student?.fullName.split(' ')[1] ?? ""}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines:3,
                        ),
                        GestureDetector(
                          onTap: () {
                            final text = student?.externalId ?? "";
                            Clipboard.setData(ClipboardData(text: text));
                            showMessage(context,AppLocalizations.of(context)!.copyText, AnimatedSnackBarType.success);
                          },
                          child: Text(
                            "ID: ${student?.externalId ?? ""}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  // IconButton(
                  //   color: AppColors.white,
                  //   onPressed: (){
                  //     themeController.toggleTheme();
                  //     themeController.update();
                  //   },
                  //   icon: Obx(() => Icon(
                  //     themeController.themeMode.value == 1
                  //         ? Icons.light_mode_outlined
                  //         : Icons.mode_night_outlined,
                  //   )),
                  // ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ Text(txt.nowInter,
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: GoogleFonts.lato().fontFamily,
                      ), ),
                      Text(interStatus,
                        style: TextStyle(
                          color: interStatus == "ACTIVE" ? AppColors.appActiveGreen : interStatus == "PENDING" ? AppColors.appActiveBlue : AppColors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: GoogleFonts.lato().fontFamily,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: isLoading
                        ? null
                        : () async {
                      isLoading = true;
                      update();

                      final response = await httpService
                          .getMyInternships(box.values.first.accessToken);

                      isLoading = false;

                      if (response.statusCode == 200) {
                        update();
                        final data =
                        jsonDecode(response.body)['data'] as List<dynamic>;

                        final practices = data
                            .map((e) => InternshipModel.fromJson(e))
                            .toList();

                        final selected = await showPracticeListDialog(
                          context: context,
                          title: txt.interList,
                          practices: practices,
                          optionsBuilder: () => {"Yopish": null},
                        );

                        if (selected != null) {
                          await NoSqlService.saveInternship(selected);
                          update();

                          loadInternship();

                          ShowMessage.showMessage(
                            context,
                            "${selected.name} ${txt.interCheckIn}",
                            AnimatedSnackBarType.success,
                          );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) =>  SplashPage(token: token, role: role)),
                                (Route<dynamic> route) => false,
                          );
                        }
                      } else if(response.statusCode >= 401) {
                        await NoSqlService.clearAllData();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                              (Route<dynamic> route) => false,
                        );
                      } else {
                        update();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              interName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          isLoading
                              ? const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                              : const Icon(Icons.change_circle_outlined,
                              color: Colors.white, size: 26),
                        ],
                      ),
                    ),
                  ),
                ),

                _drawerInfo(Icons.group, student?.group.name ?? ""),
                _drawerInfo(Iconsax.teacher, "${student?.course}-kurs"),
                _drawerInfo(Iconsax.book, student?.speciality.name ?? ""),
                _drawerInfo(Iconsax.building, student?.faculty.name ?? ""),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.settings),

                  title: Text(AppLocalizations.of(context)!.settings,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SettingsPage()),
                    );
                  },
                ),

                // --- LOG OUT ---
                ListTile(

                  leading: Icon(Icons.logout,color: AppColors.red),
                  title: Text(txt.logout,
                      style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.red)),
                  onTap: () => logOutDialog(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20),
                      langButton("Uzb", 1,context),
                      langButton("Rus", 2,context),
                      langButton("Eng", 3,context),
                      SizedBox(width: 20)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _drawerInfo(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: AppColors.appActiveBlue),
      title: Text(
        text,
        style: TextStyle(
          color: AppColors.appActiveBlue,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget langButton(String text, int type, BuildContext context) {
    final bool isSelected = selectedLang == type;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.appActiveBlue : AppColors.white,
      ),
      onPressed: () => selectLanguage(type,context),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }

  logOutDialog(BuildContext context) async {
    final txt = AppLocalizations.of(context)!;
    bool result = await showGenericDialog(
      context: context,
      title: txt.logOutTitle,
      content: txt.logOutContent,
      optionsBuilder: () => {
        txt.noText: false,
        txt.yesText: true,
      },
    );
    if (result) {
      await  NoSqlService.clearAllData();
      Get.offAll(() => const LoginPage());
    }
  }

  logOutBlocked(BuildContext context) async {
      await NoSqlService.clearAllData();
      Get.offAll(() => const LoginPage());
  }
}