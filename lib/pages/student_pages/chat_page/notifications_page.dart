import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constands/appcolors.dart';
import '../../../constands/demo_data.dart';
import '../../../widgets/clip_wawe_left.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appActiveBlue,
          title: Text("Xabarnoma",
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

      body: Stack(
        children: [
          SizedBox(
            height: 160,
            child: ClipPath(
              clipper: WaveClipperLeft(),
              child: Container(
                color: AppColors.appActiveBlue,
              ),
            ),
          ),
          ListView.builder(
            itemCount: notificationsDemo.length,
            itemBuilder: (context, index) {
              final item = notificationsDemo[index];
              final isChecked = item["check"] as bool;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    notificationsDemo[index]["check"] = !isChecked;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                isChecked ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["description"],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight:
                                isChecked ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item["date"],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight:
                                isChecked ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // O‘ng taraf (cheklar)
                      Row(
                        children: [
                          isChecked ? Icon(
                            Icons.check,
                            color: Colors.blue,
                            size: 20,
                          ) : Icon(
                            Icons.new_releases_outlined,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
