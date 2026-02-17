import 'package:flutter/material.dart';

import 'internet_checker.dart';

class InternetBanner extends StatelessWidget {
  const InternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: InternetChecker.internetStream,
      builder: (context, snapshot) {
        final hasInternet = snapshot.data ?? true;

        if (hasInternet) return const SizedBox();

        return Container(
          width: double.infinity,
          color: Colors.red,
          padding: const EdgeInsets.all(8),
          child: const SafeArea(
            child: Text(
              "Internetga ulaning!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
