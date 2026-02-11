import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tap/languages/app_localizations.dart';

import '../../constands/appcolors.dart';
import '../../models/login_users_model/student_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../services/nosql_service.dart';
import '../../widgets/show_message/show_message.dart';
import '../student_pages/blocked_page/blocked_page.dart';
import '../student_pages/home_page/home_page.dart';

class LoadingPage extends StatefulWidget {
  final String token;
  final String role;

  const LoadingPage({super.key,required this.token,required this.role});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  final httpService = HttpService();


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (widget.role == "STUDENT") {
      final startTime = DateTime.now();

      final response = await httpService.getProfileData(widget.token);

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        LogService.d(jsonMap.toString());

        final student = StudentModel.fromJson(jsonMap['data']);
        if (student.status == "ACTIVE") {
          await NoSqlService.saveStudent(student);

          final elapsed = DateTime.now().difference(startTime);
          if (elapsed < const Duration(seconds: 2)) {
            await Future.delayed(const Duration(seconds: 2));
          }

          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
            );
          }
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BlockedPage()),
                (Route<dynamic> route) => false,
          );
        }
      } else {
        print("Failed to load student data: ${response.statusCode}");
      }
    }else{
      ShowMessage.showMessage(context,AppLocalizations.of(context)!.notStudent, AnimatedSnackBarType.info);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Lottie.asset(
          'assets/lotties/loading1.json',
          width: 400,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
