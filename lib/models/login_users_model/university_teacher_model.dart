import 'package:hive/hive.dart';

part 'university_teacher_model.g.dart';

@HiveType(typeId: 5)
class UniversityTeacher extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String fullName;

  @HiveField(2)
  String phoneNumber;

  @HiveField(3)
  String passport;

  @HiveField(4)
  String rate;

  @HiveField(5)
  String position;

  @HiveField(6)
  String universityName;

  UniversityTeacher({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.passport,
    required this.rate,
    required this.position,
    required this.universityName,
  });

  // JSON -> model
  factory UniversityTeacher.fromJson(Map<String, dynamic> json) {
    return UniversityTeacher(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      passport: json['passport'] ?? '',
      rate: json['rate']?.toString() ?? '',
      position: json['position'] ?? '',
      universityName: json['universityName'] ?? '',
    );
  }

  // model -> JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'passport': passport,
      'rate': rate,
      'position': position,
      'universityName': universityName,
    };
  }
}
