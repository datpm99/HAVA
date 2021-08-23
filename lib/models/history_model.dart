import 'package:flutter/material.dart';

class HistoryModel {
  final int catId;
  final int historyId;
  final int idExam;
  final String title;
  final int trueAnswer;
  final int totalQues;
  final String date;
  final List<int> lstAnswer;
  final int type;

  HistoryModel({
    required this.catId,
    required this.historyId,
    required this.idExam,
    required this.title,
    required this.trueAnswer,
    required this.totalQues,
    required this.date,
    required this.lstAnswer,
    required this.type,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      catId: json['catId'] ?? 0,
      historyId: json['historyId'] ?? 0,
      idExam: json['examId'] ?? 0,
      title: json['title'] ?? '',
      trueAnswer: json['trueAnwer'] ?? 0,
      totalQues: json['total_question'] ?? 0,
      date: json['date'] ?? '',
      lstAnswer: json['lstAnswer'].cast<int>() ?? [],
      type: json['type'] ?? 0,
    );
  }
}

class HistoryModelList {
  final List<HistoryModel> list;

  HistoryModelList({required this.list});

  factory HistoryModelList.fromJson(List obs) {
    List<HistoryModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => HistoryModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return HistoryModelList(list: list);
  }
}

class HisChart {
  final double point;
  final int num;

  HisChart({required this.point, required this.num});
}
