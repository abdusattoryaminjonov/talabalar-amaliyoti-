import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constands/appcolors.dart';

class ShowMockLocationDialog {
  static  void showCustomDialog(BuildContext context, String title) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_off_outlined,
                size: 50,
                color: AppColors.red,
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color:AppColors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Yolg'on lokatsiyadan foydalanish, talaba akkauntini bloklanishiga olib kelishi mumkin!",
                style: TextStyle(fontSize: 16, color: AppColors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appActiveBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 18, color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}