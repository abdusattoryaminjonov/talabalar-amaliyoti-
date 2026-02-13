import 'package:flutter/material.dart';
import 'package:tap/languages/app_localizations.dart';

Future<void> showAppNoticeDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.noticeTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                AppLocalizations.of(context)!.noticeText1,
              ),
              SizedBox(height: 12),

              Text(
                AppLocalizations.of(context)!.noticeText2,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.noticeText3,
              ),
              SizedBox(height: 10),

              Text(
                AppLocalizations.of(context)!.noticeText4,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.noticeText5,
              ),
              SizedBox(height: 12),

              Divider(),
              SizedBox(height: 8),

              Text(
                AppLocalizations.of(context)!.noticeText6,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.noticeText7,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:  Text(AppLocalizations.of(context)!.noticeGetIt),
          ),
        ],
      );
    },
  );
}
