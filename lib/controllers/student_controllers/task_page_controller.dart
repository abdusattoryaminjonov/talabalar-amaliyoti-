import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../constands/appcolors.dart';
import '../../constands/demo_data.dart';
import '../../models/login_users_model/internship_model.dart';
import '../../pages/student_pages/task_page/task_view_page.dart';

class TaskPageController extends GetxController{

  late Box<InternshipModel> internshipBox;

  String interName = "";


  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> _getTasksForDate(DateTime date) {
    return tasks.values
        .where((task) => task['startdate'] == date.toString().split(" ")[0])
        .toList();
  }

  Map<String, dynamic>? getTaskByTaskId(int taskId) {
    try {
      return tasks.values.firstWhere(
            (task) => task["taskid"].toString() == taskId.toString(),
      );
    } catch (e) {
      return null;
    }
  }

  Widget chosenInternship(BuildContext context,String name){
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
            name,
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

  Widget bodyTask(BuildContext context,String interName, int interId) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        chosenInternship(context,interName),
        const SizedBox(height: 10,),
        Expanded(
          child: Builder(
            builder: (context) {
              final allTasks = tasks.values.toList();

              allTasks.sort((a, b) {
                DateTime aDate = DateTime.parse(a['startdate']);
                DateTime bDate = DateTime.parse(b['startdate']);

                int aDiff = (aDate.difference(selectedDate)).inDays.abs();
                int bDiff = (bDate.difference(selectedDate)).inDays.abs();

                return aDiff.compareTo(bDiff);
              });

              if (allTasks.isEmpty) {
                return const Center(
                  child: Text("Topshiriqlar mavjud emas"),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: allTasks.length + 1,
                itemBuilder: (context, index) {
                  if (index == allTasks.length) {
                    return const SizedBox(height: 60);
                  }
                  final task = allTasks[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.only(left: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizedBox(width: 2),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: (task['taskstatus'] == 'opened' ||
                                            task['taskstatus'] == 'answered' ||
                                            task['taskstatus'] == 'ranked')
                                            ? AppColors.appActivePer
                                            : AppColors.black05,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Icon(
                                            Icons.file_copy_sharp,
                                            color: (task['uploadcounts'] > 0)
                                                ? AppColors.appActivePer
                                                : AppColors.black05,
                                            size: 20,
                                          ),
                                          task['uploadcounts'] != 0
                                              ? Positioned(
                                            top: -4,
                                            right: -6,
                                            child: Container(
                                              padding:
                                              const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .appActiveGreen,
                                                shape: BoxShape.circle,
                                              ),
                                              constraints:
                                              const BoxConstraints(
                                                minWidth: 14,
                                                minHeight: 14,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  task['uploadcounts']
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 8,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                  textAlign:
                                                  TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.check_circle,
                                        color: task['taskstatus'] == 'ranked'
                                            ? AppColors.appActivePer
                                            : AppColors.black05,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                task['tasktype'] == "oquv"
                                    ? Icon(Icons.school,
                                    color: AppColors.appActiveBlue)
                                    : Icon(Icons.person,
                                    color: AppColors.appActiveBlue),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    task['tasktitle'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: task['taskstatus'] == 'new'
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _buildDetailRow(
                              'Muddat: ',
                              "${task['startdate']} - ${task['enddate']}",
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => TaskViewPage(
                                      id: int.parse(task['taskid'])),
                                ));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.appActiveBlue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Ko'rish",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        task['taskrank'] > 0
                            ? Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.appActiveBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                task['taskrank'].toString(),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }

}