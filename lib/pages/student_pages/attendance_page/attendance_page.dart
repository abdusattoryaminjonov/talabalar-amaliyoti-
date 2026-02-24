import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tap/pages/student_pages/attendance_page/logs_and_map.dart';
import '../../../constands/appcolors.dart';
import '../../../controllers/student_controllers/attendace_page_controller.dart';
import '../../../languages/app_localizations.dart';
import '../../../models/login_users_model/internship_model.dart';
import '../../../services/nosql_service.dart';
import '../../../widgets/dialogs/show_notice_dialog.dart';

class AttendancePage extends StatefulWidget {
  final String interName;
  final int interId;

  const AttendancePage({
    super.key,
    required this.interName,
    required this.interId,
  });

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  final attendancePageController = Get.find<AttendancePageController>();

  @override
  void initState() {
    super.initState();
    attendancePageController.checkLocationPermission(context);

    attendancePageController.internshipBox = Hive.box<InternshipModel>("internshipBox");

    if (attendancePageController.internshipBox.isNotEmpty) {
      attendancePageController.interName =
          attendancePageController.internshipBox.values.first.name;
      attendancePageController.interId =
          attendancePageController.internshipBox.values.first.id;
    } else {
      attendancePageController.interName = "";
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      attendancePageController.loadData(
        attendancePageController.interId,
        NoSqlService.getLogin()!.accessToken,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final txt = AppLocalizations.of(context)!;

    return GetBuilder<AttendancePageController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leadingWidth: 80,
            backgroundColor: AppColors.appActiveBlue,
            centerTitle: true,
            title: Text(
              txt.attendancesCalender,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                    Icons.info_outline,
                  color: AppColors.white,
                ),
                onPressed: () {
                  showAppNoticeDialog(context);
                },
              ),
              SizedBox(width: 5)
            ],
            leading: controller.interId == -1 ? SizedBox.shrink() : InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LogsAndMap(logsByDateList: attendancePageController.logsByDateList,expectedLat: double.parse(attendancePageController.expectedLat),expectedLon:  double.parse(attendancePageController.expectedLon),),
                ));
              },
              child: Center(
                child: Image.asset(
                  'assets/images/google_map.png',
                  width: 260,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          body: controller.interId == -1 ?
          controller.notData(context) : SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            header: WaterDropHeader(
              waterDropColor: Colors.transparent,
              idleIcon: Icon(Icons.refresh,color: AppColors.appActiveBlue),
              complete: Icon(Icons.check, color: Colors.green),
            ),
            onRefresh: () async {
              await controller.loadData(
                controller.interId,
                NoSqlService.getLogin()!.accessToken,
              );
              controller.refreshController.refreshCompleted();
            },
            child: controller.isPageLoading ?
            Center(
                child: SizedBox(
                  width: 150,
                  child: Lottie.asset("assets/lotties/loading1.json"),
                )
            ) : ListView(
              children: [
                const SizedBox(height: 10),
                controller.chosenInternship(context, controller.interName),
                const SizedBox(height: 10),
                TableCalendar(
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030),
                  focusedDay: controller.focusedDay,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.updateDay(selectedDay, focusedDay);
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppColors.appActiveBlue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.appActiveBlueOch,
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      final key =
                          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                      if (!controller.attendancesMap.containsKey(key)) return null;

                      return Positioned(
                        bottom: 4,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                controller.selectedDay == null
                    ? Center(
                  child: Text(
                    txt.choseDay,
                    style: TextStyle(
                      color: AppColors.appActiveBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                  ),
                )
                    : controller.buildDayInfo(
                  controller.selectedDay!,
                  context,
                  NoSqlService.getLogin()!.accessToken,
                  controller.interId,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}
