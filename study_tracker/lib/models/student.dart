import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String avatar;

  @HiveField(3)
  String birthDate;

  @HiveField(4)
  String address;

  @HiveField(5)
  String email;

  Student({
    required this.id,
    required this.name,
    required this.avatar,
    required this.birthDate,
    required this.address,
    required this.email,
  });
}
