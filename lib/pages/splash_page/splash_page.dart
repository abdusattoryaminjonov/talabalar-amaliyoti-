import 'dart:async';
import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../languages/app_localizations.dart';
import '../../models/login_users_model/student_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../services/nosql_service.dart';
import '../../widgets/show_message/show_message.dart';
import '../student_pages/home_page/home_page.dart';
import '../student_pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  final String token;
  final String role;

  const SplashPage({super.key, required this.token,required this.role});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  double _opacity = 0;
  double _scale = 0.5;

  final httpService = HttpService();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1;
        _scale = 1.3;
      });

    });
    _loadData();
  }

  Future<void> _loadData() async {
    if (widget.role != "STUDENT") {
      if (!mounted) return;
      ShowMessage.showMessage(
        context,
        AppLocalizations.of(context)!.notStudent,
        AnimatedSnackBarType.info,
      );
      return;
    }

    final startTime = DateTime.now();

    try {
      final response = await httpService
          .getProfileData(widget.token)
          .timeout(const Duration(seconds: 10));

      LogService.i('STATUS: ${response.statusCode}');

      if (!mounted) return;

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        LogService.d(jsonMap.toString());

        final student = StudentModel.fromJson(jsonMap['data']);
        await NoSqlService.saveStudent(student);

        final elapsed = DateTime.now().difference(startTime);
        if (elapsed < const Duration(seconds: 2)) {
          await Future.delayed(const Duration(seconds: 2) - elapsed);
        }

        if (!mounted) return;
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offAll(
                () => HomePage(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 350),
          );
        });

      }

      else if (response.statusCode == 401 || response.statusCode == 403) {
        ShowMessage.showMessage(
          context,
          AppLocalizations.of(context)!.dataIsOutdated,
          AnimatedSnackBarType.info,
        );

        await NoSqlService.clearAllData();

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            pageBuilder: (context, animation, secondaryAnimation) =>
                LoginPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
              (Route<dynamic> route) => false,
        );

      }

      else if (response.statusCode >= 500) {
        ShowMessage.showMessage(
          context,
          AppLocalizations.of(context)!.serverError,
          AnimatedSnackBarType.error,
        );
      }

      else {
        LogService.e('Unexpected status: ${response.statusCode}');
        ShowMessage.showMessage(
          context,
          AppLocalizations.of(context)!.unknownError,
          AnimatedSnackBarType.error,
        );
      }
    }

    on TimeoutException {
      if (!mounted) return;
      ShowMessage.showMessage(
        context,
        AppLocalizations.of(context)!.connectionTimeout,
        AnimatedSnackBarType.warning,
      );
    }

    catch (e, s) {
      LogService.e(e.toString());
      LogService.e(s.toString());

      if (!mounted) return;
      ShowMessage.showMessage(
        context,
        AppLocalizations.of(context)!.unknownError,
        AnimatedSnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 2),
          child: AnimatedScale(
            scale: _scale,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            child: Image.asset(
              'assets/images/uznpu.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
