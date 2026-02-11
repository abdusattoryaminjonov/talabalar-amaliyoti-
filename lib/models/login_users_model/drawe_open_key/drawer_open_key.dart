import 'package:hive/hive.dart';

part 'drawer_open_key.g.dart';

@HiveType(typeId: 7)
class DrawerOpenKey extends HiveObject {

  @HiveField(0)
  bool status;

  DrawerOpenKey({
    required this.status,
  });

  factory DrawerOpenKey.fromJson(Map<String, dynamic> json) => DrawerOpenKey(
    status: json["status"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
