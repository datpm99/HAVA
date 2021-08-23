class AnswerModel {
  int answer;
  int id_question;

  AnswerModel({required this.answer, required this.id_question});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'answer': answer,
        'id_question': id_question,
      };
}

class ListAnswerModel {
  int id_exam;
  List<AnswerModel> answerModel;
  int test_schedules_id;
  int type;

  ListAnswerModel(
      {required this.id_exam,
      required this.answerModel,
      required this.test_schedules_id,
      required this.type});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_exam': id_exam,
        'list_answer': answerModel,
        'test_schedules_id': test_schedules_id,
        'type': type,
      };
}

class ListExeModel {
  int idExam;
  List<AnswerModel> answerModel;

  ListExeModel({required this.idExam, required this.answerModel});

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id_exam': idExam,
    'list_answer': answerModel,
  };
}
