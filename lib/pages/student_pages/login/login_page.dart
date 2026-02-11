import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap/constands/appcolors.dart';

import '../../../controllers/login_page_controller.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<LoginPageController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<LoginPageController>(
      builder: (_){
        return Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomInset: false,
          body:GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: height < 500
                ? SingleChildScrollView(child: controller.buildContent(context))
                // ? controller.buildContent(context)
                : controller.buildContent(context),
          ),
        );
      },
    );
  }
}

