import 'package:flutter/material.dart';

class ExamModel {
  final int id;
  final String title;
  final int categoryId;
  final int isRandom;
  final int isDone;
  final int isFree;
  final int level;

  ExamModel(
      {required this.id,
      required this.title,
      required this.categoryId,
      required this.isRandom,
      required this.isDone,
      required this.isFree,
      required this.level});

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      title: json['title'],
      categoryId: json['categoryId'],
      isRandom: json['isRandom'],
      isDone: json['isDone'],
      isFree: json['isFree'],
      level: json['level'],
    );
  }
}

class ExamModelList {
  final List<ExamModel> list;

  ExamModelList({required this.list});

  factory ExamModelList.fromJson(List obs) {
    List<ExamModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => ExamModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return ExamModelList(list: list);
  }
}

class ExamScheduleModel {
  final String begin;
  final String end;
  final int isRepeat;
  final int examId;
  final String subjectName;
  final int categoryId;
  final int id;

  ExamScheduleModel({
    required this.begin,
    required this.end,
    required this.isRepeat,
    required this.examId,
    required this.subjectName,
    required this.categoryId,
    required this.id,
  });

  factory ExamScheduleModel.fromJson(Map<String, dynamic> json) {
    return ExamScheduleModel(
      begin: json['begin'],
      end: json['end'],
      isRepeat: json['isRepeat'],
      examId: json['examId'],
      subjectName: json['subjectName'],
      categoryId: json['categoryId'],
      id: json['id'],
    );
  }
}
