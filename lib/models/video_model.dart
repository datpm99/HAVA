import 'package:flutter/material.dart';

class VideoModel {
  final int id;
  final String title;
  final String thumbnail;
  final String href;
  final String contents;

  VideoModel(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.href,
      required this.contents});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      href: json['href'] ?? '',
      contents: json['contents'],
    );
  }
}

class VideoModelList {
  final List<VideoModel> list;

  VideoModelList({required this.list});

  factory VideoModelList.fromJson(List obs) {
    List<VideoModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => VideoModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return VideoModelList(list: list);
  }
}
