import 'package:flutter/material.dart';

class FeedBackModel {
  final int id;
  final String title;
  final String thumbnail;
  final String description;
  final String contents;

  FeedBackModel(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.description,
      required this.contents});

  factory FeedBackModel.fromJson(Map<String, dynamic> json) {
    return FeedBackModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      description: json['despication'],
      contents: json['contents'],
    );
  }
}

class FeedBackModelList {
  final List<FeedBackModel> list;

  FeedBackModelList({required this.list});

  factory FeedBackModelList.fromJson(List obs) {
    List<FeedBackModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => FeedBackModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return FeedBackModelList(list: list);
  }
}
