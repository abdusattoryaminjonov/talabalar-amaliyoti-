// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NPUU Internship';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Log out';

  @override
  String get enter => 'NPUU\nInternship';

  @override
  String get loginInput => 'Enter login';

  @override
  String get password => 'Password';

  @override
  String get passInput => 'Enter password';

  @override
  String get forgotPass => 'Forgot your password?';

  @override
  String get empty => 'The input field is empty';

  @override
  String get incorrect => 'Incorrect username or password.';

  @override
  String get serverError => 'Server error.';

  @override
  String get errorPlease => 'Error, please try again later.';

  @override
  String get notStudent => 'You are not a STUDENT.';

  @override
  String get dataIsOutdated => 'User data is out of date. Please log in again.';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get connectionTimeout => 'Unable to connect to the Internet';

  @override
  String get logsAndMap => 'Attempts';

  @override
  String get nowInter => 'Current Interval';

  @override
  String get notChoseInter => 'Interval not selected!';

  @override
  String get interList => 'Intervals list';

  @override
  String get interCheckIn => 'Selected';

  @override
  String get logOutTitle => 'Logout';

  @override
  String get logOutContent => 'Are you sure you want to log out?';

  @override
  String get noText => 'No';

  @override
  String get yesText => 'Yes';

  @override
  String get notEnterTxt => 'NOT ENTERED';

  @override
  String get toComeText => 'COMING';

  @override
  String get toGoText => 'GOING';

  @override
  String get taskText => 'task';

  @override
  String get view => 'View';

  @override
  String get semesterKText => 'Fall semester';

  @override
  String get semesterBText => 'Spring semester';

  @override
  String get lostTimeText => 'Lost hours';

  @override
  String get moreText => 'More';

  @override
  String get tasksScoreText => 'Assignment score';

  @override
  String get tasksText => 'Assignments';

  @override
  String get attendancesCalender => 'Attendance Calendar';

  @override
  String get choseDay => 'Choose Day';

  @override
  String get locationMessage => 'GPS permission permanently denied!';

  @override
  String get notData => 'No data on this day';

  @override
  String get lieLocation => 'Lie Location detected!';

  @override
  String get goOutAtt => 'Outgoing attendance';

  @override
  String get toGoAtt => 'Outgoing attendance';

  @override
  String get toComeAtt => 'Arriving attendance';

  @override
  String get logsEmpty => 'No logs for this day';

  @override
  String get copyText => 'Copied';

  @override
  String get settings => 'Settings';

  @override
  String get passSuccess => 'Password updated successfully';

  @override
  String get passError => 'An error occurred';

  @override
  String get passConnection => 'Network error';

  @override
  String get passOld => 'Old password';

  @override
  String get passEnterOld => 'Enter old password';

  @override
  String get passNew => 'New password';

  @override
  String get passEnterNew => 'Password must be at least 6 characters';

  @override
  String get passCheck => 'Confirm new password';

  @override
  String get passNotTrue => 'Passwords do not match';

  @override
  String get passOk => 'Update password';

  @override
  String get score => 'Rating';

  @override
  String get scoreGroup => 'Group';

  @override
  String get scoreType => 'Specialization';

  @override
  String get sortScore => 'Sort by Score';

  @override
  String get sortLostTime => 'Sort by Hours Left';

  @override
  String get attendance => 'Attendance';

  @override
  String get scoreA => 'Score';

  @override
  String get comIn => 'Incoming message';

  @override
  String get comOut => 'Outgoing message';

  @override
  String get optionalMessage => 'Write a message (optional)...';

  @override
  String get cancelText => 'Cancel';

  @override
  String get submitText => 'Submit';

  @override
  String get submitMainIdeTxt =>
      'By clicking the \"SUBMIT\" button, the arrival/departure attendance of the internship location will be sent.';

  @override
  String get notWorking => 'This feature is not working. It is being created.';
}
