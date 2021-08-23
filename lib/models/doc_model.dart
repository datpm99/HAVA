import 'package:flutter/material.dart';

class DocModel {
  final int id;
  final String title;
  final String thumbnail;
  final String href;
  final int docCateId;

  DocModel(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.href,
      required this.docCateId});

  factory DocModel.fromJson(Map<String, dynamic> json) {
    return DocModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      href: json['href'],
      docCateId: json['document_category_id'],
    );
  }
}

class DocModelList {
  final List<DocModel> list;

  DocModelList({required this.list});

  factory DocModelList.fromJson(List obs) {
    List<DocModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => DocModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return DocModelList(list: list);
  }
}
