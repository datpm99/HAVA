import 'package:flutter/material.dart';

class TotalHisModel {
  int idTheory;
  String title;
  int totalQuestionOfCat;
  int selectedQuestionTrue;
  int totalQuestionTrue;
  int totalQuestion;
  List<ListAnsModel>? listAns;

  TotalHisModel(
      {required this.idTheory,
      required this.title,
      required this.totalQuestionOfCat,
      required this.selectedQuestionTrue,
      required this.totalQuestionTrue,
      required this.totalQuestion,
      required this.listAns});

  factory TotalHisModel.fromJson(Map<String, dynamic> json) {
    return TotalHisModel(
      idTheory: json['id_theory'] ?? 0,
      title: json['title'] ?? '',
      totalQuestionOfCat: json['total_question_of_cat'] ?? 0,
      selectedQuestionTrue: json['selected_question_true'] ?? 0,
      totalQuestionTrue: json['total_question_true'] ?? 0,
      totalQuestion: json['total_question'] ?? 0,
      listAns: json.containsKey('list_answer')
          ? ListAnsModelList.fromJson(json['list_answer']).list
          : null,
    );
  }
}

class TotalHisModelList {
  final List<TotalHisModel> list;

  TotalHisModelList({required this.list});

  factory TotalHisModelList.fromJson(List obs) {
    List<TotalHisModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => TotalHisModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return TotalHisModelList(list: list);
  }
}

class ListAnsModel {
  int questionNumber;
  int isRight;

  ListAnsModel({required this.questionNumber, required this.isRight});

  factory ListAnsModel.fromJson(Map<String, dynamic> json) {
    return ListAnsModel(
      questionNumber: json['question_number'] ?? 0,
      isRight: json['is_right'] ?? 0,
    );
  }
}

class ListAnsModelList {
  final List<ListAnsModel> list;

  ListAnsModelList({required this.list});

  factory ListAnsModelList.fromJson(List obs) {
    List<ListAnsModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => ListAnsModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return ListAnsModelList(list: list);
  }
}
