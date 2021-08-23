import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class QuestionModel extends HiveObject{
  final int id;
  final int idExam;
  final String title;
  final String index;
  final int labelId;
  String valueLable;
  String question;
  String hints;
  String answer;
  String comments;
  final int answerTrue;
  String answerA;
  String answerB;
  String answerC;
  String answerD;
  final int categoryId;
  final int level;
  final int isLabel;
  final int labelOf;

  QuestionModel(
      {required this.id,
      required this.idExam,
      required this.title,
      required this.index,
      required this.labelId,
      required this.valueLable,
      required this.question,
      required this.hints,
      required this.answer,
      required this.comments,
      required this.answerTrue,
      required this.answerA,
      required this.answerB,
      required this.answerC,
      required this.answerD,
      required this.categoryId,
      required this.level,
      required this.isLabel,
      required this.labelOf});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      idExam: json['idExam'] ?? 0,
      title: json['title'],
      index: json['index'] ?? '',
      labelId: json['labelId'],
      question: json['question'],
      hints: json['hints'],
      answer: json['answer'],
      comments: json['comments'],
      answerTrue: json['answerTrue'],
      answerA: json['answerA'],
      answerB: json['answerB'],
      answerC: json['answerC'],
      answerD: json['answerD'],
      categoryId: json['categoryId'],
      level: json['level'],
      isLabel: json['isLabel'],
      labelOf: json['labelOf'],
      valueLable: json['valueLable'] ?? '',
    );
  }
}

class QuestionModelList {
  final List<QuestionModel> list;

  QuestionModelList({required this.list});

  factory QuestionModelList.fromJson(List obs) {
    List<QuestionModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => QuestionModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return QuestionModelList(list: list);
  }
}
