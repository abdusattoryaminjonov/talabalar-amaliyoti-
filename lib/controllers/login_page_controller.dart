import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../constands/appcolors.dart';
import '../languages/app_localizations.dart';
import '../models/login_users_model/nosql_login.dart';
import '../pages/loading_page/loading_page.dart';
import '../services/http_service.dart';
import '../services/language_service.dart';
import '../services/log_service.dart';
import '../services/nosql_service.dart';
import '../widgets/clip_wawe.dart';

class LoginPageController extends GetxController{

  final httpService = HttpService();

  final TextEditingController hemisController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool showLanguages = false;

  bool isLoading = false;


  void showMessage(BuildContext context, String message, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
      message,
      type: type,
      duration: const Duration(seconds: 2)
    ).show(context);
  }

  void showUserErrorDialog(BuildContext context, String title, String message,String user) {
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
              const Icon(
                Icons.perm_device_info,
                size: 50,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Foydalanuvchi : ",
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                "${user.split(' ')[0]} ${user.split(' ')[1]}",
                maxLines: 3,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appActiveBlue
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Tartib raqami: ${message}",
                style: const TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Accauntingizni tiklash uchun\nAmaliyot bo'limiga murojat qiling!",
                style: TextStyle(fontSize: 16, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () => Get.back(),
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context,String login,String password) async {
    isLoading = true;
    update();

    if (login.isEmpty || password.isEmpty) {
      showMessage(context,AppLocalizations.of(context)!.empty, AnimatedSnackBarType.warning);

      isLoading = false;
      update();
      return;
    }

    try {
      var response = await httpService.login(login, password);
      LogService.i(response.body);

      switch (response.statusCode) {
        case 200:
        case 201:
          final data = jsonDecode(response.body);

          final loginData = LoginUserData.fromJson(data);

          await NoSqlService.saveLogin(loginData);

          String accessToken = data['data']['accessToken'];
          String refreshToken = data['data']['refreshToken'];
          String role = data['data']['role'];
          LogService.e(accessToken);
          LogService.e(refreshToken);
          LogService.e(role);

          if (context.mounted) {
            showMessage(context,loginData.message, AnimatedSnackBarType.success);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoadingPage(
                token: accessToken,
                role: role,
              ),
            ));
          }
          isLoading = false;
          update();

          break;

        case 404:


          if (context.mounted) {
            showMessage(context,AppLocalizations.of(context)!.incorrect,AnimatedSnackBarType.error);
          }
          isLoading = false;
          update();

          break;

        case 423:

          final data1 = jsonDecode(response.body);
          final message = data1["message"];

          if (context.mounted) {
            showMessage(context,message,AnimatedSnackBarType.error);
          }
          isLoading = false;
          update();

          break;

        default:
          LogService.e("Error: ${response.statusCode}");
          if (context.mounted) {
            showMessage(context,AppLocalizations.of(context)!.serverError,AnimatedSnackBarType.error);
          }
          isLoading = false;
          update();
          break;
      }

    } catch (e) {
      showMessage(context,AppLocalizations.of(context)!.errorPlease, AnimatedSnackBarType.warning);
      showMessage(context,AppLocalizations.of(context)!.connectionTimeout, AnimatedSnackBarType.error);
      LogService.e(e.toString());
      isLoading = false;
      update();
    }
  }


  void updateObsText(){
    obscureText = !obscureText;
    update();
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: const Text("Tilni tanlang"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _langItem(context, "O‘zbek", 1),
              _langItem(context, "Русский", 2),
              _langItem(context, "English", 3),
            ],
          ),
        );
      },
    );
  }

  Locale getLocaleFromType(int type) {
    switch (type) {
      case 1:
        return const Locale('uz');
      case 2:
        return const Locale('ru');
      case 3:
        return const Locale('en');
      default:
        return const Locale('uz');
    }
  }

  Widget _langItem(BuildContext context, String title, int type) {
    return ListTile(
      title: Text(title),
      onTap: () async {
        await LanguageService.saveLanguage(type);
        Get.updateLocale(getLocaleFromType(type));

        Navigator.pop(context);
      },
    );
  }


  Widget buildContent(BuildContext context){
    return  Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: AppColors.appActiveBlue,
                  height: 230,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 24),
                        SizedBox(
                          width: 60,
                          child: Image.asset("assets/images/npuu.png"),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.enter,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:  Icon(Icons.language, size: 30, color: AppColors.appActiveBlue),
                    onPressed: () {
                      showLanguageDialog(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HEMIS ID",
                  style: TextStyle(fontSize: 18, color: AppColors.black),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: hemisController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.loginInput,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  AppLocalizations.of(context)!.password,
                  style: TextStyle(fontSize: 18, color: AppColors.black),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,

                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.passInput,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed:(){
                        updateObsText();
                      },
                    ),
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //
                //     },
                //     child: Text(
                //       AppLocalizations.of(context)!.forgotPass,
                //       style: TextStyle(
                //         color: AppColors.appActiveBlue,
                //         fontSize: 14,
                //       ),
                //     ),
                //   ),
                // ),
                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appActiveBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      String username =
                      hemisController.text.trim();
                      String password =
                      passwordController.text.trim();

                      login(context, username, password);
                    },
                    child: isLoading ? CircularProgressIndicator(color: AppColors.white,) : Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}