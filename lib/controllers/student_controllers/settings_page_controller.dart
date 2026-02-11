import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap/languages/app_localizations.dart';

import '../../constands/appcolors.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../services/nosql_service.dart';

class SettingsPageController extends GetxController{

  final httpService = HttpService();
  final auth = NoSqlService.getLogin();

  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureOld = true;
  bool obscureNew = true;
  bool obscureConfirm = true;
  bool isLoading = false;

  void showMessage(BuildContext context, String message, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
        message,
        type: type,
        duration: const Duration(seconds: 2)
    ).show(context);
  }

  InputDecoration inputDecoration(String label, bool obscure, VoidCallback toggle) {
    return InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: toggle,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  void _clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> updatePass(BuildContext context, String token) async {
    if (!formKey.currentState!.validate()) return;

    final currentPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    isLoading = true;
    update();

    LogService.e(currentPass);
    LogService.e(newPass);
    LogService.e(confirmPass);

    try {
      final response = await httpService.updatePassword(currentPass, newPass, confirmPass, token);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showMessage(context, AppLocalizations.of(context)!.passSuccess, AnimatedSnackBarType.success);
        _clearFields();
      } else {
        final message = body["message"] ?? AppLocalizations.of(context)!.passError;
        showMessage(context, message, AnimatedSnackBarType.error);
      }
    } catch (e) {
      showMessage(context, "${AppLocalizations.of(context)!.passConnection}: $e", AnimatedSnackBarType.error);
    }finally{
      isLoading = false;
      update();
    }
  }


  Widget updatePassword(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 6,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: oldPasswordController,
                obscureText: obscureOld,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.passOld,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(obscureOld ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      obscureOld = !obscureOld;
                      update();
                    },
                  ),
                ),
                validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.passEnterOld : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: newPasswordController,
                obscureText: obscureNew,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.passNew,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(obscureNew ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      obscureNew = !obscureNew;
                      update();
                    },
                  ),
                ),
                validator: (value) => value!.length < 6 ? AppLocalizations.of(context)!.passEnterNew : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirm,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.passCheck,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(obscureConfirm ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      obscureConfirm = !obscureConfirm;
                      update();
                    },
                  ),
                ),
                validator: (value) {
                  if (value != newPasswordController.text) return AppLocalizations.of(context)!.passNotTrue;
                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => updatePass(context, auth!.accessToken),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appActiveBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : Text(
                    AppLocalizations.of(context)!.passOk,
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}