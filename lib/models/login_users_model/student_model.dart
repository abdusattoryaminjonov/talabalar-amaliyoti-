import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String externalId;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String passport;

  @HiveField(4)
  final String pinFl;

  @HiveField(5)
  final String citizenship;

  @HiveField(6)
  final String nationality;

  @HiveField(7)
  final String? imageUrl;

  @HiveField(8)
  final String birthDate;

  @HiveField(9)
  final String gender;

  @HiveField(10)
  final String region;

  @HiveField(11)
  final String district;

  @HiveField(12)
  final String status;

  @HiveField(13)
  final String educationLanguage;

  @HiveField(14)
  final String educationForm;

  @HiveField(15)
  final String educationType;

  @HiveField(16)
  final int course;

  @HiveField(17)
  final String username;

  @HiveField(18)
  final String role;

  @HiveField(19)
  final int semester;

  @HiveField(20)
  final Faculty faculty;

  @HiveField(21)
  final Group group;

  @HiveField(22)
  final Speciality speciality;

  StudentModel({
    required this.fullName,
    required this.externalId,
    required this.email,
    required this.passport,
    required this.pinFl,
    required this.citizenship,
    required this.nationality,
    this.imageUrl,
    required this.birthDate,
    required this.gender,
    required this.region,
    required this.district,
    required this.status,
    required this.educationLanguage,
    required this.educationForm,
    required this.educationType,
    required this.course,
    required this.username,
    required this.role,
    required this.semester,
    required this.faculty,
    required this.group,
    required this.speciality,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"] ?? json;

    return StudentModel(
      fullName: data["fullName"] ?? "",
      externalId: data["externalId"]?.toString() ?? "",
      email: data["email"] ?? "",
      passport: data["passport"] ?? "",
      pinFl: data["pinFl"] ?? "",
      citizenship: data["citizenship"] ?? "",
      nationality: data["nationality"] ?? "",
      imageUrl: data["imageUrl"],
      birthDate: data["birthDate"] ?? "",
      gender: data["gender"] ?? "",
      region: data["region"] ?? "",
      district: data["district"] ?? "",
      status: data["status"] ?? "",
      educationLanguage: data["educationLanguage"] ?? "",
      educationForm: data["educationForm"] ?? "",
      educationType: data["educationType"] ?? "",
      course: data["course"] ?? 0,
      semester: data["semester"] ?? 0,
      username: data["username"] ?? "",
      role: data["role"] ?? "",
      faculty: Faculty.fromJson(data["faculty"] ?? {}),
      group: Group.fromJson(data["group"] ?? {}),
      speciality: Speciality.fromJson(data["specialityResponse"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "externalId": externalId,
    "email": email,
    "passport": passport,
    "pinFl": pinFl,
    "citizenship": citizenship,
    "nationality": nationality,
    "imageUrl": imageUrl,
    "birthDate": birthDate,
    "gender": gender,
    "region": region,
    "district": district,
    "status": status,
    "educationLanguage": educationLanguage,
    "educationForm": educationForm,
    "educationType": educationType,
    "course": course,
    "semester": semester,
    "username": username,
    "role": role,
    "faculty": faculty.toJson(),
    "group": group.toJson(),
    "specialityResponse": speciality.toJson(),
  };
}

@HiveType(typeId: 1)
class Faculty {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String code;

  Faculty({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) => Faculty(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    code: json["code"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}

@HiveType(typeId: 2)
class Group {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String code;

  @HiveField(3)
  final String educationLanguage;

  @HiveField(4)
  final int semester;

  Group({
    required this.id,
    required this.name,
    required this.code,
    required this.educationLanguage,
    required this.semester,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    code: json["code"] ?? "",
    educationLanguage: json["educationLanguage"] ?? "",
    semester: json["semester"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "educationLanguage": educationLanguage,
    "semester": semester,
  };
}

@HiveType(typeId: 3)
class Speciality {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String code;

  @HiveField(2)
  final String name;

  Speciality({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
    id: json["id"] ?? 0,
    code: json["code"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
  };
}
