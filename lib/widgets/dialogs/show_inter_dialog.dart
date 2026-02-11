import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constands/appcolors.dart';
import '../../models/login_users_model/internship_model.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<InternshipModel?> showPracticeListDialog({
  required BuildContext context,
  required String title,
  required List<InternshipModel> practices,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();

  return showDialog<InternshipModel>(
    context: context,
    builder: (context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              letterSpacing: 0,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            height: 300,
            child: CupertinoScrollbar(
              child: ListView.builder(
                itemCount: practices.length,
                itemBuilder: (context, index) {
                  final p = practices[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(p),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text("Boshlanish: ${p.activeStartAt.split('T').first ?? "no Date"}"),
                        Text("Tugash: ${p.activeEndAt.split('T').first ?? "no Date"}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${p.status}",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: p.status == "ACTIVE" ? AppColors.appActiveGreen :
                                p.status == "PENDING" ? AppColors.appActiveBlue :
                                p.status == "COMPLETED" ? AppColors.red :
                                AppColors.black
                            ),),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.black),
              child: Text(optionTitle),
              onPressed: () {
                Navigator.of(context).pop(value);
              },
            );
          }).toList(),
        );
      }

      return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: practices.length,
              itemBuilder: (context, index) {
                final p = practices[index];
                return InkWell(
                  onTap: () => Navigator.of(context).pop(p),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                    elevation: 1,
                    color: Colors.grey.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text("${p.activeStartAt} → ${p.activeEndAt}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("${p.status}",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: p.status == "ACTIVE" ? AppColors.appActiveGreen :
                                  p.status == "PENDING" ? AppColors.appActiveBlue :
                                  p.status == "COMPLETED" ? AppColors.red :
                                  AppColors.red
                              ),),
                            ],
                          ),
                          const SizedBox(height: 2),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () => Navigator.of(context).pop(value),
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
