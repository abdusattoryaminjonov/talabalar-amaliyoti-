import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/login_users_model/drawe_open_key/drawer_open_key.dart';
import '../models/login_users_model/internship_model.dart';
import '../models/login_users_model/nosql_login.dart';
import '../models/login_users_model/student_model.dart';
import '../models/login_users_model/university_teacher_model.dart';
import 'log_service.dart';

class NoSqlService {
  static late Box<LoginUserData> loginBox;
  static late Box<StudentModel> studentBox;
  static late Box<UniversityTeacher> uTeacherBox;
  static late Box<InternshipModel> internshipBox;
  static late Box<DrawerOpenKey> drawerTutorialBox;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    Hive
      ..registerAdapter(LoginUserDataAdapter())
      ..registerAdapter(StudentModelAdapter())
      ..registerAdapter(FacultyAdapter())
      ..registerAdapter(GroupAdapter())
      ..registerAdapter(SpecialityAdapter())
      ..registerAdapter(UniversityTeacherAdapter())
      ..registerAdapter(InternshipModelAdapter())
      ..registerAdapter(DrawerOpenKeyAdapter());

    loginBox = await Hive.openBox<LoginUserData>("loginBox");
    studentBox = await Hive.openBox<StudentModel>("studentBox");
    uTeacherBox = await Hive.openBox<UniversityTeacher>("teacherBox");
    internshipBox = await Hive.openBox<InternshipModel>('internshipBox');
    drawerTutorialBox = await Hive.openBox<DrawerOpenKey>('drawer_tutorial');
  }

  // ---------- STUDENT ----------
  static Future<void> saveStudent(StudentModel student) async {
    await studentBox.put("currentStudent", student);
    LogService.i("Student saved: ${student.toJson()}");
  }

  static StudentModel? getStudent() {
    return studentBox.get("currentStudent");
  }

  static Future<void> clearStudent() async {
    await studentBox.delete("currentStudent");
  }

  // ---------- LOGIN ----------
  static Future<void> saveLogin(LoginUserData login) async {
    await loginBox.put("user", login);
    LogService.i("Login saved: ${login.toJson()}");
  }

  static LoginUserData? getLogin() {
    return loginBox.get("user");
  }

  static Future<void> clearLogin() async {
    await loginBox.delete("user");
  }

  // ---------- TEACHER ----------
  static Future<void> saveTeacher(UniversityTeacher teacher) async {
    await uTeacherBox.put("currentTeacher", teacher);
    LogService.i("Teacher saved: ${teacher.toJson()}");
  }

  static UniversityTeacher? getTeacher() {
    return uTeacherBox.get("currentTeacher");
  }

  static Future<void> clearTeacher() async {
    await uTeacherBox.delete("currentTeacher");
  }

  // --------- Internship -------

  static Future<void> saveInternship(InternshipModel internship) async {
    await internshipBox.delete('current_internship');
    await internshipBox.put('current_internship', internship);
    LogService.i('Internship saqlandi: ${internship.name}');
  }

  static InternshipModel? getSavedInternship() {
    return internshipBox.get('current_internship');
  }

  static Future<void> updateInternship(InternshipModel internship) async {
    await internshipBox.put('current_internship', internship);
    LogService.i('Internship yangilandi: ${internship.name}');
  }

  static Future<void> deleteInternship() async {
    await internshipBox.delete('current_internship');
    LogService.i('Internship o‘chirildi');
  }

  static Future<void> clearAllInternship() async {
    await internshipBox.delete('current_internship');
  }

  // --------- DrawerOpenKey -------

  static DrawerOpenKey getDrawerTutorial() {
    return drawerTutorialBox.get(
      'drawer',
      defaultValue: DrawerOpenKey(status: false),
    )!;
  }

  static Future<void> markDrawerTutorialSeen() async {
    await drawerTutorialBox.put(
      'drawer',
      DrawerOpenKey(status: true),
    );
  }

  static Future<void> resetDrawerTutorial() async {
    await drawerTutorialBox.delete('drawer');
  }


  static Future<void> clearAllData() async {
    try {
      await loginBox.clear();
      await studentBox.clear();
      await uTeacherBox.clear();
      await internshipBox.delete('current_internship');
      await drawerTutorialBox.clear();

      LogService.i("Barcha NoSQL (Hive) ma'lumotlar tozalandi");
    } catch (e) {
      LogService.e("Ma'lumotlarni tozalashda xato: $e");
    }
  }
}
