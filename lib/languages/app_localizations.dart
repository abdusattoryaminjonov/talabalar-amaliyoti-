import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'languages/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'NPUU Internship'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'NPUU\nInternship'**
  String get enter;

  /// No description provided for @loginInput.
  ///
  /// In en, this message translates to:
  /// **'Enter login'**
  String get loginInput;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passInput.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passInput;

  /// No description provided for @forgotPass.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPass;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'The input field is empty'**
  String get empty;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect username or password.'**
  String get incorrect;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error.'**
  String get serverError;

  /// No description provided for @errorPlease.
  ///
  /// In en, this message translates to:
  /// **'Error, please try again later.'**
  String get errorPlease;

  /// No description provided for @notStudent.
  ///
  /// In en, this message translates to:
  /// **'You are not a STUDENT.'**
  String get notStudent;

  /// No description provided for @dataIsOutdated.
  ///
  /// In en, this message translates to:
  /// **'User data is out of date. Please log in again.'**
  String get dataIsOutdated;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the Internet'**
  String get connectionTimeout;

  /// No description provided for @logsAndMap.
  ///
  /// In en, this message translates to:
  /// **'Attempts'**
  String get logsAndMap;

  /// No description provided for @nowInter.
  ///
  /// In en, this message translates to:
  /// **'Current Interval'**
  String get nowInter;

  /// No description provided for @notChoseInter.
  ///
  /// In en, this message translates to:
  /// **'Interval not selected!'**
  String get notChoseInter;

  /// No description provided for @interList.
  ///
  /// In en, this message translates to:
  /// **'Intervals list'**
  String get interList;

  /// No description provided for @interCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get interCheckIn;

  /// No description provided for @logOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOutTitle;

  /// No description provided for @logOutContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logOutContent;

  /// No description provided for @noText.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noText;

  /// No description provided for @yesText.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesText;

  /// No description provided for @notEnterTxt.
  ///
  /// In en, this message translates to:
  /// **'NOT ENTERED'**
  String get notEnterTxt;

  /// No description provided for @toComeText.
  ///
  /// In en, this message translates to:
  /// **'COMING'**
  String get toComeText;

  /// No description provided for @toGoText.
  ///
  /// In en, this message translates to:
  /// **'GOING'**
  String get toGoText;

  /// No description provided for @taskText.
  ///
  /// In en, this message translates to:
  /// **'task'**
  String get taskText;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @semesterKText.
  ///
  /// In en, this message translates to:
  /// **'Fall semester'**
  String get semesterKText;

  /// No description provided for @semesterBText.
  ///
  /// In en, this message translates to:
  /// **'Spring semester'**
  String get semesterBText;

  /// No description provided for @lostTimeText.
  ///
  /// In en, this message translates to:
  /// **'Lost hours'**
  String get lostTimeText;

  /// No description provided for @moreText.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreText;

  /// No description provided for @tasksScoreText.
  ///
  /// In en, this message translates to:
  /// **'Assignment score'**
  String get tasksScoreText;

  /// No description provided for @tasksText.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get tasksText;

  /// No description provided for @attendancesCalender.
  ///
  /// In en, this message translates to:
  /// **'Attendance Calendar'**
  String get attendancesCalender;

  /// No description provided for @choseDay.
  ///
  /// In en, this message translates to:
  /// **'Choose Day'**
  String get choseDay;

  /// No description provided for @locationMessage.
  ///
  /// In en, this message translates to:
  /// **'GPS permission permanently denied!'**
  String get locationMessage;

  /// No description provided for @notData.
  ///
  /// In en, this message translates to:
  /// **'No data on this day'**
  String get notData;

  /// No description provided for @lieLocation.
  ///
  /// In en, this message translates to:
  /// **'Lie Location detected!'**
  String get lieLocation;

  /// No description provided for @goOutAtt.
  ///
  /// In en, this message translates to:
  /// **'Outgoing attendance'**
  String get goOutAtt;

  /// No description provided for @toGoAtt.
  ///
  /// In en, this message translates to:
  /// **'Outgoing attendance'**
  String get toGoAtt;

  /// No description provided for @toComeAtt.
  ///
  /// In en, this message translates to:
  /// **'Arriving attendance'**
  String get toComeAtt;

  /// No description provided for @logsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No logs for this day'**
  String get logsEmpty;

  /// No description provided for @copyText.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copyText;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @passSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get passSuccess;

  /// No description provided for @passError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get passError;

  /// No description provided for @passConnection.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get passConnection;

  /// No description provided for @passOld.
  ///
  /// In en, this message translates to:
  /// **'Old password'**
  String get passOld;

  /// No description provided for @passEnterOld.
  ///
  /// In en, this message translates to:
  /// **'Enter old password'**
  String get passEnterOld;

  /// No description provided for @passNew.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get passNew;

  /// No description provided for @passEnterNew.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passEnterNew;

  /// No description provided for @passCheck.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get passCheck;

  /// No description provided for @passNotTrue.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passNotTrue;

  /// No description provided for @passOk.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get passOk;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get score;

  /// No description provided for @scoreGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get scoreGroup;

  /// No description provided for @scoreType.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get scoreType;

  /// No description provided for @sortScore.
  ///
  /// In en, this message translates to:
  /// **'Sort by Score'**
  String get sortScore;

  /// No description provided for @sortLostTime.
  ///
  /// In en, this message translates to:
  /// **'Sort by Hours Left'**
  String get sortLostTime;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @scoreA.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get scoreA;

  /// No description provided for @comIn.
  ///
  /// In en, this message translates to:
  /// **'Incoming message'**
  String get comIn;

  /// No description provided for @comOut.
  ///
  /// In en, this message translates to:
  /// **'Outgoing message'**
  String get comOut;

  /// No description provided for @optionalMessage.
  ///
  /// In en, this message translates to:
  /// **'Write a message (optional)...'**
  String get optionalMessage;

  /// No description provided for @cancelText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelText;

  /// No description provided for @submitText.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitText;

  /// No description provided for @submitMainIdeTxt.
  ///
  /// In en, this message translates to:
  /// **'By clicking the \"SUBMIT\" button, the arrival/departure attendance of the internship location will be sent.'**
  String get submitMainIdeTxt;

  /// No description provided for @notWorking.
  ///
  /// In en, this message translates to:
  /// **'This feature is not working. It is being created.'**
  String get notWorking;

  /// No description provided for @pageNotTitle.
  ///
  /// In en, this message translates to:
  /// **'This page is currently unavailable'**
  String get pageNotTitle;

  /// No description provided for @pageNotDes.
  ///
  /// In en, this message translates to:
  /// **'Technical work is underway.\nPlease try again later.'**
  String get pageNotDes;

  /// No description provided for @noTime.
  ///
  /// In en, this message translates to:
  /// **'Lost hours not yet calculated'**
  String get noTime;

  /// No description provided for @noticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Important Information'**
  String get noticeTitle;

  /// No description provided for @noticeText1.
  ///
  /// In en, this message translates to:
  /// **'To use this application properly, we may request access to certain permissions. Please read the information below carefully.'**
  String get noticeText1;

  /// No description provided for @noticeText2.
  ///
  /// In en, this message translates to:
  /// **'• Location Permission'**
  String get noticeText2;

  /// No description provided for @noticeText3.
  ///
  /// In en, this message translates to:
  /// **'The application may request access to your location to provide better services and features.\nYour location data is used only within the application and is not shared with third parties.'**
  String get noticeText3;

  /// No description provided for @noticeText4.
  ///
  /// In en, this message translates to:
  /// **'• Notification Permission'**
  String get noticeText4;

  /// No description provided for @noticeText5.
  ///
  /// In en, this message translates to:
  /// **'The application may send notifications to inform you about important updates and reminders.'**
  String get noticeText5;

  /// No description provided for @noticeText6.
  ///
  /// In en, this message translates to:
  /// **'Privacy and Data Usage'**
  String get noticeText6;

  /// No description provided for @noticeText7.
  ///
  /// In en, this message translates to:
  /// **'The application collects only the minimum data required for its functionality.\nAll data is stored securely and is not sold or shared with third parties.'**
  String get noticeText7;

  /// No description provided for @noticeGetIt.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get noticeGetIt;

  /// No description provided for @buildingMarkerTitle.
  ///
  /// In en, this message translates to:
  /// **'Internship Building'**
  String get buildingMarkerTitle;

  /// No description provided for @iTitle.
  ///
  /// In en, this message translates to:
  /// **'Character Description'**
  String get iTitle;

  /// No description provided for @iDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get iDate;

  /// No description provided for @iDateDesc.
  ///
  /// In en, this message translates to:
  /// **'Today\'s date, or selected date'**
  String get iDateDesc;

  /// No description provided for @iPoint.
  ///
  /// In en, this message translates to:
  /// **'Operation point'**
  String get iPoint;

  /// No description provided for @iPointDesc.
  ///
  /// In en, this message translates to:
  /// **'The designated point is the practice building'**
  String get iPointDesc;

  /// No description provided for @iWrongLoc.
  ///
  /// In en, this message translates to:
  /// **'Wrong location'**
  String get iWrongLoc;

  /// No description provided for @iWrongLocDesc.
  ///
  /// In en, this message translates to:
  /// **'The point where you tried to go outside the designated area repeatedly'**
  String get iWrongLocDesc;

  /// No description provided for @iCircle.
  ///
  /// In en, this message translates to:
  /// **'Boundary'**
  String get iCircle;

  /// No description provided for @iCircleDesc.
  ///
  /// In en, this message translates to:
  /// **'The boundary of the practice building'**
  String get iCircleDesc;

  /// No description provided for @iEnd.
  ///
  /// In en, this message translates to:
  /// **'Please note that if no information is displayed and the google map is empty, please select the practice base on the home page!'**
  String get iEnd;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
