import 'package:hive/hive.dart';

part 'language_model.g.dart';

@HiveType(typeId: 8)
class LanguageModel extends HiveObject {

  @HiveField(0)
  int type;

  LanguageModel({
    required this.type,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    type: json["type"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "type": type,
  };
}
