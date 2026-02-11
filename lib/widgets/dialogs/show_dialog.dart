import 'package:flutter/material.dart';

import '../../constands/appcolors.dart';

class ShowDialogHelper {
  static void showCustomDialog(BuildContext context,String title, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,style: TextStyle(
            color: color,
            fontSize: 20,
          ),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok",style: TextStyle(
                fontSize: 20,
                  color: AppColors.appActiveBlue
              ),),
            ),
          ],
        );
      },
    );
  }

  static void showProfileCustomDialog(BuildContext context,String title,String content , Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,style: TextStyle(
            color: color,
            fontSize: 20,
          ),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(content,style: TextStyle(
                color: color,
                fontSize: 15,
              ),),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok",style: TextStyle(
                fontSize: 20,
                  color: AppColors.appActiveBlue
              ),),
            ),
          ],
        );
      },
    );
  }
}
