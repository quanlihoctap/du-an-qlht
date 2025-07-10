import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String hashedPassword;

  @HiveField(2)
  String displayName;

  User({
    required this.username,
    required this.hashedPassword,
    required this.displayName,
  });
}