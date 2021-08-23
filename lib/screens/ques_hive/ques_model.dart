import 'package:hava/models/question_model.dart';
import 'package:hive/hive.dart';

part 'ques_model.g.dart';

@HiveType(typeId: 3)
class QuesModel extends HiveObject {
  @HiveField(0)
  List<QuestionModel> listQues;

  QuesModel({required this.listQues});
}
