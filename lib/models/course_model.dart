import 'package:flutter/material.dart';

class CourseModel {
  final int id;
  final String title;

  CourseModel({required this.id, required this.title});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      title: json['title'],
    );
  }
}

class CourseModelList {
  final List<CourseModel> list;

  CourseModelList({required this.list});

  factory CourseModelList.fromJson(List obs) {
    List<CourseModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => CourseModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return CourseModelList(list: list);
  }
}
