import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../../constands/appcolors.dart';
import '../../../constands/demo_data.dart';
import '../../../controllers/home_page_controller.dart';
import '../../../controllers/student_controllers/dashboard_page_controller.dart';
import '../../../languages/app_localizations.dart';
import '../../../models/login_users_model/internship_model.dart';
import '../../../models/login_users_model/nosql_login.dart';
import '../../../models/login_users_model/student_model.dart';
import '../../../services/nosql_service.dart';
import '../../../widgets/clip_wawe_tolqin.dart';
import '../../../widgets/show_message/show_message.dart';
import 'carousel_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final dashboardController = Get.find<DashboardPageController>();
  final homeController = Get.find<HomePageController>();
  StudentModel? student;

  @override
  void initState() {
    super.initState();

    // dashboardController.notLength = notificationsDemo.length;
    dashboardController.box = Hive.box<LoginUserData>("loginBox");
    student = homeController.studentBox.get("currentStudent");

    dashboardController.internshipBox = Hive.box<InternshipModel>("internshipBox");
    dashboardController.internshipModel =
        dashboardController.internshipBox.get("current_internship");


    dashboardController.interName =
        dashboardController.internshipModel?.name ?? "Amaliyot tanlanmagan!";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dashboardController.loadAttendances(dashboardController.internshipModel?.id ?? 1, NoSqlService.getLogin()!.accessToken);
      dashboardController.loadDateTime(
        dashboardController.internshipModel?.id ?? 1,
        NoSqlService.getLogin()!.accessToken,
        context,
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardPageController>(
      builder: (_){
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: AppColors.appActiveBlue,
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onTap: (){
                homeController.scaffoldKey.currentState?.openDrawer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dashboardController.getFirstName(student!.fullName),
                    key: homeController.drawerOpenKey,
                    style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),),

                  Icon(
                    Icons.navigate_next_outlined,
                    color: AppColors.white,
                    // fontWeight: FontWeight.bold,
                    weight: 700,
                  )
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  ShowMessage.showMessage(context,AppLocalizations.of(context)!.notWorking, AnimatedSnackBarType.info);
                },
                // dashboardController.goToRatingPage(context);


                icon: Icon(Icons.star_border),
                color: Colors.white,
                iconSize: 30,
              ),
              GestureDetector(
                onTap: (){
                  dashboardController.goToNotificationPage(context);
                },
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        ShowMessage.showMessage(context,AppLocalizations.of(context)!.notWorking, AnimatedSnackBarType.info);
                      },

                      // dashboardController.goToNotificationPage(context);

                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      iconSize: 30,
                    ),

                    dashboardController.notLength != 0 ? Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          dashboardController.notLength.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ) : SizedBox.shrink(),
                  ],
                ),
              )
            ],
          ),
          body:  Stack(
            children: [
              SizedBox(
                height: 92,
                child: ClipPath(
                  clipper: WaveClipperTolqin(),
                  child: Container(
                    color: AppColors.appActiveBlue,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [

                    SimpleCarousel(),
                    SizedBox(height: 20,),
                    dashboardController.isDateTimeLoading ?
                    dashboardController.todayAttendanceTime(context) : SizedBox.shrink(),
                    // SizedBox(height: 20,),
                    // dashboardController.tasksViewCard(265,188,context),
                    SizedBox(height: 10,),
                    dashboardController.soatBallRating(homeController,context),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}