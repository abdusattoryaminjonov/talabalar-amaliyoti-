import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/home_page_controller.dart';

class BlockedPage extends StatefulWidget {
  const BlockedPage({super.key});

  @override
  State<BlockedPage> createState() => _BlockedPageState();
}

class _BlockedPageState extends State<BlockedPage> {
  final homeController = Get.find<HomePageController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.asset("assets/lotties/blocked.json"),
            MaterialButton(
                onPressed: (){
                  homeController.logOutDialog(context);
                },
              child: Text("Log in"),
            )
          ],
        ),
      ),
    );
  }
}
