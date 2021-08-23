import 'package:hive/hive.dart';

part 'remind_model.g.dart';

@HiveType(typeId: 1)
class RemindModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String time;
  @HiveField(3)
  bool isAlarm;
  @HiveField(4)
  List<int> listRepeat;
  @HiveField(5)
  bool isDefault;

  RemindModel(
      {required this.id,
      required this.title,
      required this.time,
      required this.isAlarm,
      required this.listRepeat,
      required this.isDefault});
}
