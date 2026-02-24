import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:tap/languages/app_localizations.dart';
import 'package:tap/services/app_color/theme_controller.dart';
import 'package:tap/services/intranet/internet_service.dart';

import '../../../constands/appcolors.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/student_controllers/dashboard_page_controller.dart';
import '../../../models/login_users_model/internship_model.dart';
import '../../../models/login_users_model/nosql_login.dart';
import '../../../models/login_users_model/student_model.dart';
import '../../../services/language_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final dashboardController = Get.find<DashboardPageController>();
  final homeController = Get.find<HomePageController>();
  // final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    homeController.selectedLang = LanguageService.getLanguageType();
    homeController.box = Hive.box<LoginUserData>('loginBox');
    homeController.studentBox = Hive.box<StudentModel>('studentBox');
    homeController.internshipBox = Hive.box<InternshipModel>("internshipBox");
    // FirebaseMessaging.onBackgroundMessage(homeController.firebaseMessagingBackgroundHandler);

    homeController.initialFunction(context);
    homeController.loadInternship();
    // homeController.requestPermission();
    // homeController.getToken();
    // homeController.subscribeToTopic();

    if (homeController.box.values.isNotEmpty) {
      homeController.token = homeController.box.values.first.accessToken;
      homeController.role = homeController.box.values.first.role;
    }

    if (homeController.internshipBox.values.isNotEmpty) {
      homeController.interName = homeController.internshipBox.values.first.name;
      homeController.interId = homeController.internshipBox.values.first.id;
    } else {
      homeController.interName = "Amaliyot tanlanmagan!";
      homeController.interId = -1;
    }

    dashboardController.updateInter();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          key: homeController.scaffoldKey,
          drawer: GetBuilder<HomePageController>(
            builder: (controller) {
              return controller.showDrawer(context,homeController.token,homeController.role);
            },
          ),
          onDrawerChanged: (bool isOpened) {
            if (!isOpened) {
              dashboardController.updateInter();
            }
          },

          body: homeController.pages[homeController.bottomNavIndex],

          floatingActionButton: SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              backgroundColor: homeController.isLoading
                  ? Colors.white
                  : AppColors.appActiveBlue,
              onPressed: () {
                homeController.changePage(2);
              },
              child: homeController.isLoading
                  ? SizedBox(
                width: 60,
                height: 60,
                child: Lottie.asset("assets/lotties/loading.json"),
              )
                  : Icon(
                Icons.date_range,
                size: 35,
                color: AppColors.white,
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: AnimatedBottomNavigationBar.builder(
              itemCount: homeController.iconList.length,
              tabBuilder: (int index, bool isActive) {
                final color =
                isActive ? AppColors.appActiveBlue : AppColors.black50;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      homeController.iconList[index],
                      size: 30,
                      color: color,
                    ),
                  ],
                );
              },
              backgroundColor: AppColors.white,
              activeIndex: homeController.bottomNavIndex,
              splashColor: AppColors.appActiveBlue,
              notchAndCornersAnimation: homeController.borderRadiusAnimation,
              splashSpeedInMilliseconds: 300,
              notchSmoothness: NotchSmoothness.defaultEdge,
              gapLocation: GapLocation.center,
              leftCornerRadius: 20,
              rightCornerRadius: 20,
              onTap: (index) => homeController.changePage(index),
              hideAnimationController:
              homeController.hideBottomBarAnimationController,
            ),
          ),
        );
      },
    );
  }
}
