import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap/languages/app_localizations.dart';

import '../../constands/appcolors.dart';
import '../../constands/demo_data.dart';

class RatingPageController extends GetxController{
  bool sortByScore = true;

  void showMessage(BuildContext context, String message, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
        message,
        type: type,
        duration: const Duration(seconds: 4)
    ).show(context);
  }

  void sortAllData() {
    final group = ratingData["group"]!;
    final sortedGroup = Map.fromEntries(group.entries.toList()
      ..sort((a, b) {
        if (sortByScore) {
          return (b.value["total-ball"] as int)
              .compareTo(a.value["total-ball"] as int);
        } else {
          return (a.value["attendance"] as int)
              .compareTo(b.value["attendance"] as int);
        }
      }));
    ratingData["group"] = sortedGroup;

    final speciality = ratingData["speciality"]!;
    final sortedSpeciality = Map.fromEntries(speciality.entries.toList()
      ..sort((a, b) {
        if (sortByScore) {
          return (b.value["total-ball"] as int)
              .compareTo(a.value["total-ball"] as int);
        } else {
          return (b.value["attendance"] as int)
              .compareTo(a.value["attendance"] as int);
        }
      }));
    ratingData["speciality"] = sortedSpeciality;
  }


  void toggleSort(BuildContext context) {
    showMessage(context,!sortByScore ? AppLocalizations.of(context)!.sortScore: AppLocalizations.of(context)!.sortLostTime,AnimatedSnackBarType.success);
    sortByScore = !sortByScore;
    sortAllData();
    update();
  }

  Widget buildList(Map<String, dynamic> data) {
    final entries = data.entries.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: entries.length + 1,
      itemBuilder: (context, index) {
        if (index == entries.length) {
          return const SizedBox(height: 90);
        }

        final entry = entries[index];
        final name = entry.key;
        final info = entry.value as Map<String, dynamic>;

        return Card(
          color: AppColors.white,
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: name == "You" || name == "you" ? AppColors.red : AppColors.appActiveBlue,
              child: Text(name[0],style: TextStyle(
                  color: AppColors.white
              ),),
            ),
            title: Text(
              name,
              style: TextStyle(
                color: AppColors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
            subtitle: sortByScore ? Text("${AppLocalizations.of(context)!.attendance}: ${info['attendance']} s") : Text("${AppLocalizations.of(context)!.scoreA}: ${info['total-ball']}"),
            trailing: sortByScore ? Text(
              "${AppLocalizations.of(context)!.scoreA}: ${info['total-ball']}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ) : Text(
              "${AppLocalizations.of(context)!.attendance}: ${info['attendance']} s",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }


}