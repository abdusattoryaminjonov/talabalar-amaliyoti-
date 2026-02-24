import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tap/pages/splash_page/splash_page.dart';
import 'package:tap/pages/student_pages/login/login_page.dart';
import 'package:tap/services/intranet/internet_service.dart';
import 'package:tap/services/language_service.dart';
import 'package:tap/services/nosql_service.dart';
import 'package:tap/services/root_service.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/root_binding.dart';
import 'languages/app_localizations.dart';
import 'models/login_users_model/language/language_model.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await RootService.init();

  // await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Hive.registerAdapter(LanguageModelAdapter());
  await LanguageService.init();

  // await ThemeService.init();
  // Get.put(ThemeController(), permanent: true);

  await InternetService.instance.initialize();

  runApp(
    OverlaySupport.global(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  @override
  Widget build(BuildContext context) {
    final login = NoSqlService.getLogin();

    final int langType = LanguageService.getLanguageType();
    final Locale appLocale = getLocaleFromType(langType);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NPUU Internship',

      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      locale: appLocale,
      fallbackLocale: const Locale('uz'),

      initialBinding: RootBinding(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: (login != null && login.accessToken.isNotEmpty)
          ? SplashPage(token: login.accessToken, role: login.role)
          // ? SplashPage(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2Njg3NDc0IiwiaWF0IjoxNzcyMTcwOTk5LCJleHAiOjE3NzIxNzExNzl9.Rva6YC5loYLT6kC5dT4yqyxgE8KtqpheKQ5ZqP70bQI", role: login.role)
          : LoginPage(),
    );
  }

}


// return GetBuilder<ThemeController>(
// builder: (controller) {
// return GetMaterialApp(
// debugShowCheckedModeBanner: false,
// title: 'NPUU Internship',
//
// theme: ThemeData.light(),
// darkTheme: ThemeData.dark(),
//
// themeMode: controller.themeMode.value == 1
// ? ThemeMode.dark
//     : ThemeMode.light,
//
// supportedLocales: AppLocalizations.supportedLocales,
// localizationsDelegates: const [
// AppLocalizations.delegate,
// GlobalMaterialLocalizations.delegate,
// GlobalWidgetsLocalizations.delegate,
// GlobalCupertinoLocalizations.delegate,
// ],
//
// locale: appLocale,
// fallbackLocale: const Locale('uz'),
//
// initialBinding: RootBinding(),
// home: (login != null && login.accessToken.isNotEmpty)
// ? SplashPage(token: login.accessToken, role: login.role)
//     : LoginPage(),
// );
// },
// );


