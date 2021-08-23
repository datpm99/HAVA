import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2, adapterName: 'UserModelAdapter')
class UserModel extends HiveObject {
  @HiveField(0)
  int userId;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String userEmail;
  @HiveField(3)
  String userPhone;
  @HiveField(4)
  String userAvatar;
  @HiveField(5)
  String birthDay;
  @HiveField(6)
  int sex;
  @HiveField(7)
  String userToken;
  @HiveField(8)
  int isSocial;
  @HiveField(9)
  bool isMath;
  @HiveField(10)
  bool isPhysics;
  @HiveField(11)
  bool isChemistry;
  @HiveField(12)
  bool isBiology;
  @HiveField(13)
  bool isEnglish;
  @HiveField(14)
  bool isLiterature;
  @HiveField(15)
  bool isGeography;
  @HiveField(16)
  bool isGDCD;
  @HiveField(17)
  bool isHistory;
  @HiveField(18)
  String address;
  @HiveField(19)
  String school;
  @HiveField(20)
  String classBelong;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAvatar,
    required this.birthDay,
    required this.sex,
    required this.userToken,
    required this.isSocial,
    required this.isMath,
    required this.isPhysics,
    required this.isChemistry,
    required this.isBiology,
    required this.isEnglish,
    required this.isLiterature,
    required this.isGeography,
    required this.isGDCD,
    required this.isHistory,
    required this.address,
    required this.school,
    required this.classBelong,
  });
}
