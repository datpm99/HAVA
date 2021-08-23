import 'package:flutter/material.dart';

class GuideModel {
  final int id;
  final String title;
  final String contents;

  GuideModel({required this.id, required this.title, required this.contents});

  factory GuideModel.fromJson(Map<String, dynamic> json) {
    return GuideModel(
      id: json['id'],
      title: json['title'],
      contents: json['contents'],
    );
  }
}

class GuideModelList {
  final List<GuideModel> list;

  GuideModelList({required this.list});

  factory GuideModelList.fromJson(List obs) {
    List<GuideModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => GuideModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return GuideModelList(list: list);
  }
}
