import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:tap/languages/app_localizations.dart';
import '../../../constands/appcolors.dart';

import '../../../controllers/student_controllers/quota_page_controller.dart';
import '../../../models/login_users_model/internship_model.dart';

class QuotaPage extends StatefulWidget {
  final String token;
  final String interName;
  final int interId;
  const QuotaPage({super.key, required this.token, required this.interId, required this.interName});

  @override
  State<QuotaPage> createState() => _QuotaPageState();
}

class _QuotaPageState extends State<QuotaPage> {
  final quotaPageController = Get.find<QuotaPageController>();

  @override
  void initState() {
    super.initState();
    quotaPageController.internshipBox = Hive.box<InternshipModel>("internshipBox");

    if (quotaPageController.internshipBox.isNotEmpty) {
      quotaPageController.interName = quotaPageController.internshipBox.values.first.name;
      quotaPageController.interId = quotaPageController.internshipBox.values.first.id;
    }

    quotaPageController.loadData(widget.token,quotaPageController.interId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appActiveBlue,
        title: Text(
          AppLocalizations.of(context)!.quota,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),
        centerTitle: true,
      ),
      body: quotaPageController.interId == -1 ?
        quotaPageController.notQuota(context) :SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              quotaPageController.chosenInternship(context),
              const SizedBox(height: 10,),
              GetBuilder<QuotaPageController>(
                builder: (_) {
                  if (quotaPageController.isLoading) {
                    return  Center(
                        child: SizedBox(
                          width: 150,
                          child: Lottie.asset("assets/lotties/loading1.json"),
                        )
                    );
                  }

                  if (quotaPageController.quotaList.isNotEmpty) {
                    return quotaPageController.quotaListBuilder(quotaPageController.quotaList,widget.token,quotaPageController.interId);
                  }

                  if (quotaPageController.quotaMap.isNotEmpty){
                    return quotaPageController.quotaItem(quotaPageController.quotaMap ,context);
                  }
                  return  Center(child: Text(AppLocalizations.of(context)!.notQuota));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
