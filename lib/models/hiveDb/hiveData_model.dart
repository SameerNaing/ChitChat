import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'hiveData_model.g.dart';

@HiveType(typeId: 0)
class Accounts {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String profilePhoto;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String uid;

  Accounts({
    @required this.userName,
    @required this.profilePhoto,
    @required this.email,
    @required this.password,
    @required this.uid,
  });
}
