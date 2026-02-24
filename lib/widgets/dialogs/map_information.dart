import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tap/constands/appcolors.dart';
import 'package:tap/languages/app_localizations.dart';

void showMapInformation(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.iTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.appActiveBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "${DateTime.now().year}-${DateTime.now().month <= 9 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.iDate, // title
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.iDateDesc, // description
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: AppColors.appActivePer),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.iPoint, // title
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.iPointDesc, // description
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: AppColors.red),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.iWrongLoc, // title
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.iWrongLocDesc, // description
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle_outlined, color: AppColors.appActiveBlue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.iCircle, // title
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                            AppLocalizations.of(context)!.iCircleDesc, // description
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Divider(),
              SizedBox(height: 8),

              Text(
                AppLocalizations.of(context)!.iEnd,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("1"),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: InteractiveViewer(
                                  child: Image.asset(
                                    Platform.isIOS
                                        ? "assets/images/home.png"
                                        : "assets/images/home.png",
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Platform.isIOS
                                  ? "assets/images/home.png"
                                  : "assets/images/home.png",
                              fit: BoxFit.contain,
                              height: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Text("2"),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: InteractiveViewer(
                                  child: Image.asset(
                                    Platform.isIOS
                                        ? "assets/images/drawerimage.jpg"
                                        : "assets/images/drawerimage.jpg",
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Platform.isIOS
                                  ? "assets/images/drawerimage.jpg"
                                  : "assets/images/drawerimage.jpg",
                              fit: BoxFit.contain,
                              height: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Text("3"),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: InteractiveViewer(
                                  child: Image.asset(
                                    Platform.isIOS
                                        ? "assets/images/clickImage.jpg"
                                        : "assets/images/clickImage.jpg",
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Platform.isIOS
                                  ? "assets/images/clickImage.jpg"
                                  : "assets/images/clickImage.jpg",
                              fit: BoxFit.contain,
                              height: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.noticeGetIt),
          ),
        ],
      );
    },
  );
}