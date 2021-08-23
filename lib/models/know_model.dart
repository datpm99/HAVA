import 'package:flutter/material.dart';

class KnowModel {
  final int id;
  final String title;
  final int examId;
  String content;

  KnowModel(
      {required this.id,
      required this.title,
      required this.examId,
      required this.content});

  factory KnowModel.fromJson(Map<String, dynamic> json) {
    return KnowModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      examId: json['examId'] ?? 0,
      content: json['contents'] ?? '',
    );
  }
}

class KnowModelList {
  final List<KnowModel> list;

  KnowModelList({required this.list});

  factory KnowModelList.fromJson(List obs) {
    List<KnowModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => KnowModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return KnowModelList(list: list);
  }
}

