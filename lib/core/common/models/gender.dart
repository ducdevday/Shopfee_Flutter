import 'package:hive/hive.dart';

part 'gender.g.dart';

@HiveType(typeId: 1)
enum Gender {
  @HiveField(0)
  FEMALE,
  @HiveField(1)
  MALE,
  @HiveField(2)
  OTHER;

  String toJson() => name;

  static Gender fromJson(String json) => values.byName(json);
}
