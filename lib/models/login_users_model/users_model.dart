import 'dart:convert';

UsersModel usersModelFromJson(String str) => UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  String message;
  int status;
  List<Datum> data;

  UsersModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String name;
  String username;
  List<String> authRoles;
  DateTime createdDate;
  DateTime updatedDate;
  bool enabled;

  Datum({
    required this.id,
    required this.name,
    required this.username,
    required this.authRoles,
    required this.createdDate,
    required this.updatedDate,
    required this.enabled,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    authRoles: List<String>.from(json["authRoles"].map((x) => x)),
    createdDate: DateTime.parse(json["createdDate"]),
    updatedDate: DateTime.parse(json["updatedDate"]),
    enabled: json["enabled"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "authRoles": List<dynamic>.from(authRoles.map((x) => x)),
    "createdDate": createdDate.toIso8601String(),
    "updatedDate": updatedDate.toIso8601String(),
    "enabled": enabled,
  };
}
