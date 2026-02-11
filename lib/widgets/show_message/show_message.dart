import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class ShowMessage {
  static void showMessage(BuildContext context, String message, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
        message,
        type: type,
        duration: const Duration(seconds: 2)
    ).show(context);
  }
}