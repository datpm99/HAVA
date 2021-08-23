import 'package:flutter/material.dart';
import 'package:hava/models/question_model.dart';
import 'package:hive/hive.dart';

class QuesHive {
  Box? box;
  static const String _quesKey = 'QuesKey';

  QuesHive() {
    initHive();
  }

  void initHive() async {
    box = await Hive.openBox(_quesKey);
  }

  Future clearBox() async {
    if(box==null) await Hive.openBox(_quesKey);
    box!.clear();
    debugPrint('Clear Box Success!');
  }

  Future checkExamSave(int idExam) async {
    if(box==null) await Hive.openBox(_quesKey);
    return box!.containsKey(idExam);
  }

  Future addExam(List<QuestionModel> listModel, int idExam) async {
    if(box==null) await Hive.openBox(_quesKey);
    box!.put(idExam, listModel);
    debugPrint('Add Exam Success!');
  }

  Future<List> getExam(int idExam) async {
    if(box==null) await Hive.openBox(_quesKey);
    debugPrint('Get List Exam Success!');
    return box!.get(idExam);
  }
}
