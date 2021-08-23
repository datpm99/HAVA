import 'package:flutter/material.dart';

class NoteModel {
  final String entry;
  final int id;
  final String themes;
  final String title;

  NoteModel({
    required this.entry,
    required this.id,
    required this.themes,
    required this.title,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      entry: json['entry'] ?? '',
      id: json['id'] ?? 0,
      themes: json['themes'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class NoteModelList {
  final List<NoteModel> list;

  NoteModelList({required this.list});

  factory NoteModelList.fromJson(List obs) {
    List<NoteModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => NoteModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return NoteModelList(list: list);
  }
}

class CreateNote {
  final String entry;
  final String themes;
  final String title;

  CreateNote({required this.entry, required this.themes, required this.title});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'entry': entry,
        'themes': themes,
        'title': title,
      };
}
