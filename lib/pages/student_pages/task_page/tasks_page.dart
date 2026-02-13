import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../../constands/appcolors.dart';
import '../../../controllers/student_controllers/task_page_controller.dart';
import '../../../languages/app_localizations.dart';
import '../../../models/login_users_model/internship_model.dart';
import '../../page_not/page_not_available.dart';

class TasksPage extends StatefulWidget {
  final String interName;
  final int interId;
  const TasksPage({super.key, required this.interName, required this.interId});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final taskPageController = Get.find<TaskPageController>();

  @override
  void initState() {
    super.initState();

    taskPageController.internshipBox = Hive.box<InternshipModel>("internshipBox");
    if (taskPageController.internshipBox.isNotEmpty) {
      taskPageController.interName =
          taskPageController.internshipBox.values.first.name;
    } else {
      taskPageController.interName = "";
    }

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskPageController>(
      builder: (controller){
        return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.appActiveBlue,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.tasksText,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.lato().fontFamily,
                ),
              ),
            ),
            // body: controller.bodyTask(context,taskPageController.interName,widget.interId),
          body: PageNotAvailableWidget(),
        );
      },
    );
  }
}
