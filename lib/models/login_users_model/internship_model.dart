import 'package:hive/hive.dart';

part 'internship_model.g.dart';

@HiveType(typeId: 6)
class InternshipModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String activeStartAt;

  @HiveField(3)
  final String activeEndAt;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final String createdDate;

  @HiveField(7)
  final String updatedDate;

  InternshipModel({
    required this.id,
    required this.name,
    required this.activeStartAt,
    required this.activeEndAt,
    required this.status,
    required this.description,
    required this.createdDate,
    required this.updatedDate,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) => InternshipModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    activeStartAt: json["activeStartAt"] ?? "",
    activeEndAt: json["activeEndAt"] ?? "",
    status: json["status"] ?? "",
    description: json["description"] ?? "",
    createdDate: json["createdDate"] ?? "",
    updatedDate: json["updatedDate"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "activeStartAt": activeStartAt,
    "activeEndAt": activeEndAt,
    "status": status,
    "description": description,
    "createdDate": createdDate,
    "updatedDate": updatedDate,
  };
}
