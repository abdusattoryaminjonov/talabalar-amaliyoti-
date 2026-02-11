import 'package:hive/hive.dart';

part 'nosql_login.g.dart';

@HiveType(typeId: 4)
class LoginUserData extends HiveObject {

  @HiveField(0)
  String message;

  @HiveField(1)
  int status;

  @HiveField(2)
  String accessToken;
  
  @HiveField(3)
  String refreshToken;

  @HiveField(4)
  String role;

  LoginUserData({
    required this.message,
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
    message: json["message"] ?? "",
    status: json["status"] ?? 0,
    accessToken: json["data"]?["accessToken"] ?? "",
    refreshToken: json["data"]?["refreshToken"] ?? "",
    role: json["data"]?["role"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "role": role,
  };
}
