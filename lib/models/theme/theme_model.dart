import 'package:hive/hive.dart';

part 'theme_model.g.dart';

@HiveType(typeId: 9)
class ThemeModel extends HiveObject {

  @HiveField(0)
  int mode;

  ThemeModel({
    required this.mode,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
    mode: json["mode"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "mode": mode,
  };
}
