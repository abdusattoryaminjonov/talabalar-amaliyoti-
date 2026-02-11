import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constands/appcolors.dart';
import '../../../controllers/student_controllers/chat_page_controller.dart';
import '../../../languages/app_localizations.dart';
import '../../../widgets/show_message/show_message.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({super.key});

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  final chatPageController = Get.find<ChatPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.white,
        appBar: AppBar(
        backgroundColor: AppColors.appActiveBlue,
        title: Text("Xabarlar",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),),
      body:Column(
        children: [
          chatPageController.buildCustomButton(icon: Icons.notifications, title: "Xabarnoma", subtitle: "Davomat qabul qilindi!", date: "9-sentabr", count: 3, onTap:(){
            // chatPageController.goToNotificationPage(context);
            ShowMessage.showMessage(context,AppLocalizations.of(context)!.notWorking, AnimatedSnackBarType.info);
          }),
          SizedBox(height: 10,),
          chatPageController.buildCustomButton(icon: Icons.chat, title: "Amaliyot", subtitle: "Qanday yordam kerak?", date: "8-sentabr", count: 1, onTap: (){
            // chatPageController.goToChatPage(context);
            ShowMessage.showMessage(context,AppLocalizations.of(context)!.notWorking, AnimatedSnackBarType.info);
          }),
        ],
      )
    );
  }


}
