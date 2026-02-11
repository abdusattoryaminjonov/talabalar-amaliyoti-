import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constands/appcolors.dart';
import '../../../constands/demo_data.dart';
import '../../../controllers/student_controllers/rating_page_controller.dart';
import '../../../languages/app_localizations.dart';


class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {

  final controller = Get.find<RatingPageController>();

  @override
  void initState() {
    super.initState();
    controller.sortAllData();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingPageController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.appActiveBlue,
              title: Text(AppLocalizations.of(context)!.score,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.sort),
                  color: AppColors.white,
                  onPressed: (){
                    controller.toggleSort(context);
                  },
                ),
              ],
              leading: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_new,color: AppColors.white,),
              ),
            ),
            body: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: ButtonsTabBar(
                    backgroundColor: AppColors.appActiveBlue,
                    unselectedBackgroundColor: Colors.grey[300],
                    labelStyle: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(color: AppColors.black,fontSize: 18),
                    radius: 10,
                    contentPadding: const EdgeInsets.symmetric(horizontal:20),
                    height: 60,
                    tabs:  [
                      Tab(icon: SizedBox.shrink(), text: AppLocalizations.of(context)!.scoreGroup),
                      Tab(icon: SizedBox.shrink(), text: AppLocalizations.of(context)!.scoreType),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      controller.buildList(ratingData["group"]!),
                      controller.buildList(ratingData["speciality"]!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
