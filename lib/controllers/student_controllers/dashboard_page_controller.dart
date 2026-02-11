import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import '../../constands/appcolors.dart';
import '../../constands/demo_data.dart';
import '../../languages/app_localizations.dart';
import '../../models/login_users_model/internship_model.dart';
import '../../models/login_users_model/nosql_login.dart';
import '../../pages/student_pages/chat_page/notifications_page.dart';
import '../../pages/student_pages/rating_page/rating_page.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../widgets/chart_widget/chart_widget.dart';
import '../home_page_controller.dart';

class DashboardPageController extends GetxController{

  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  late String date="${day.toString()}-${month <= 9 ? "0$month": month.toString() }-${year.toString()}";

  late Box<LoginUserData> box;
  late Box<InternshipModel> internshipBox;
  InternshipModel? internshipModel;
  final httpService = HttpService();
  String interName = "";

  bool isDateTimeLoading = false;

  int notLength = 0;

  String todayDate = '';
  String inTime = "";
  String outTime = "";

  String getFirstName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) return 'Student';
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isNotEmpty ? parts.first : '';
  }

  updateInter(){
    interName = internshipModel?.name ?? "";
    update(["interUpdate"]);
  }


  Future<void> loadDateTime(int interId, String token, BuildContext context) async {
    final res = await httpService.getAttendanceDaily(token, interId);
    Map<String, dynamic> json = jsonDecode(res.body);

    LogService.e(res.body);
    if(res.statusCode == 200){
      isDateTimeLoading = true;
      update();

      todayDate = json['data']['date'];
      inTime = _formatTime(json['data']['inTime'],context) ?? AppLocalizations.of(context)!.notEnterTxt;
      outTime = _formatTime(json['data']['outTime'],context) ?? AppLocalizations.of(context)!.notEnterTxt;
      update();
    }else{
      isDateTimeLoading = false;
      update();
    }

    update();

  }


  Widget chosenInternship(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: MediaQuery.of(context).size.width, // eni
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.appActiveBlueOch,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            interName,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.lato().fontFamily,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget todayAttendanceTime(BuildContext context){
    final txt =  AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(todayDate,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),),
          ],

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              txt.toComeText,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
            Text(
              txt.toGoText,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    inTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    outTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.lato().fontFamily,

                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }

  Widget tasksViewCard(double sizeX,double sizeY, BuildContext context){
    final txt =  AppLocalizations.of(context)!;

    return SizedBox(
      height: sizeY,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final g = demoTasks[index];
          return Container(
            width: sizeX,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.appActiveBlueOch,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon + Title + Description
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.pending_actions, size: 30, color: Colors.blue),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${date} ${txt.taskText}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            g["name"],
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: GoogleFonts.lato().fontFamily,
                              color: Colors.black,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print("${txt.view} ${g["id"]}");
                    },
                    icon: const Icon(Icons.visibility, size: 18),
                    label:  Text(txt.view),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ballViewCard(BuildContext context) {
    final txt =  AppLocalizations.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  txt.semesterKText,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                        color: AppColors.appActiveGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: GoogleFonts.lato().fontFamily,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "0",
                      style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: GoogleFonts.lato().fontFamily,
                      ),
                    ),
                  ],
                )
              ],
            ),

            Container(
              width: 1,
              height: 50,
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 8),
            ),

            Column(
              children: [
                Text(
                  txt.semesterBText,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                        color: AppColors.appActiveGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: GoogleFonts.lato().fontFamily,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "0",
                      style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: GoogleFonts.lato().fontFamily,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingViewCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: MediaQuery.of(context).size.width, // eni
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.appActiveBlueOch,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                interName,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.lato().fontFamily,

                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget soatBallRating(HomePageController homeController, BuildContext context){
    final txt =  AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                txt.lostTimeText,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ),
              TextButton(
                onPressed: (){
                  homeController.changePage(4);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      txt.moreText,
                      style: TextStyle(
                        color: AppColors.appActiveBlue,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.lato().fontFamily,
                      ),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: AppColors.appActiveBlue,
                      // fontWeight: FontWeight.bold,
                      weight: 700,
                    )
                  ],
                ),
              )
            ],
          ),
          ChartWidgetCard(
            chartData: dayTimeNumbers,
          ),
          SizedBox(height: 10,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       txt.tasksScoreText,
          //       style: TextStyle(
          //         color: AppColors.black,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 15,
          //         fontFamily: GoogleFonts.lato().fontFamily,
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: (){
          //         homeController.changePage(1);
          //       },
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Text(
          //             txt.moreText,
          //             style: TextStyle(
          //               color: AppColors.appActiveBlue,
          //               fontWeight: FontWeight.bold,
          //               fontFamily: GoogleFonts.lato().fontFamily,
          //             ),
          //           ),
          //           Icon(
          //             Icons.navigate_next,
          //             color: AppColors.appActiveBlue,
          //             // fontWeight: FontWeight.bold,
          //             weight: 700,
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          //
          // ballViewCard(context),

          SizedBox(height: 100),
        ],
      ),
    );
  }

  goToNotificationPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
  }

  goToRatingPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RatingPage()),
    );
  }


  String _formatTime(String? iso, BuildContext context) {
    if (iso == null) return AppLocalizations.of(context)!.notEnterTxt;
    final dt = DateTime.parse(iso).toLocal();
    return "${dt.hour.toString().padLeft(2, "0")}:${dt.minute.toString().padLeft(2, "0")}";
  }
}