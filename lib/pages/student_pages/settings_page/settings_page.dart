import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap/languages/app_localizations.dart';

import '../../../constands/appcolors.dart';
import '../../../controllers/student_controllers/settings_page_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsPageController>(
      builder: (controller){
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.appActiveBlue,
            centerTitle: true,
            title: Text(AppLocalizations.of(context)!.settings,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: AppColors.white,
              ),
            ),
          ),
          body: controller.updatePassword(context),
        );
      },
    );
  }
}
