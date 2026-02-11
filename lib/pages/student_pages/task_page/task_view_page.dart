import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constands/appcolors.dart';
import '../../../controllers/student_controllers/task_page_controller.dart';

class TaskViewPage extends StatefulWidget {
  final int id;
  const TaskViewPage({super.key, required this.id});

  @override
  State<TaskViewPage> createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  final taskPageController =  Get.find<TaskPageController>();

  int id = 0;
  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    final task = taskPageController.getTaskByTaskId(id);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appActiveBlue,
        title: Text("Topshiriq tafsilotlari",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_outlined,color: AppColors.white,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: task == null ? Center(child: Text("Topshiriq topilmadi")): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task["tasktitle"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Vazifa beruvchi: ${task["tasker"]}"),
            Text("Muddat: ${task["startdate"]} - ${task["enddate"]}"),
            Text("Kurs: ${task["course"]}"),
            Text("Ball: ${task["taskball"]}"),
            Text("Turi: ${task["tasktype"]}"),
            Text("Status: ${task["taskstatus"]}"),
          ],
        ),
      ),
    );
  }

}
