import 'package:flutter/material.dart';

class SearchModel {
  final int id;
  final String title;
  final String path;

  SearchModel({required this.id, required this.title, required this.path});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      path: json['path'] ?? '',
    );
  }
}

class SearchModelList {
  final List<SearchModel> list;

  SearchModelList({required this.list});

  factory SearchModelList.fromJson(List obs) {
    List<SearchModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => SearchModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return SearchModelList(list: list);
  }
}
