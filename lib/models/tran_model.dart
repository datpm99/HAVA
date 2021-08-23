import 'package:flutter/material.dart';

class TranModel {
  final double avgAllTerm;
  final double avgTerm1;
  final double avgTerm2;
  final String classBelong;
  final int id;
  final String name;
  final String title;
  final int totalSub;

  TranModel({
    required this.avgAllTerm,
    required this.avgTerm1,
    required this.avgTerm2,
    required this.classBelong,
    required this.id,
    required this.name,
    required this.title,
    required this.totalSub,
  });

  factory TranModel.fromJson(Map<String, dynamic> json) {
    return TranModel(
      avgAllTerm: json['avgAllTerm'] ?? 0.0,
      avgTerm1: json['avgTerm1'] ?? 0.0,
      avgTerm2: json['avgTerm2'] ?? 0.0,
      classBelong: json['classBelong'] ?? '',
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      totalSub: json['totalSub'] ?? 0,
    );
  }
}

class TranModelList {
  final List<TranModel> list;

  TranModelList({required this.list});

  factory TranModelList.fromJson(List obs) {
    List<TranModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => TranModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return TranModelList(list: list);
  }
}

class CreateTranModel {
  final List<String> listSub;
  final String classBelong;
  final String name;
  final String title;

  CreateTranModel({
    required this.listSub,
    required this.classBelong,
    required this.name,
    required this.title,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'LstSubject': listSub,
        'classBelong': classBelong,
        'name': name,
        'title': title,
      };
}

class MarkModel {
  final List<ItemMarkModel> listMark;
  final int id;
  final String subject;

  MarkModel({required this.listMark, required this.id, required this.subject});

  factory MarkModel.fromJson(Map<String, dynamic> json) {
    return MarkModel(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? '',
      listMark: ItemMarkModelList.fromJson(json['ListMark']).list,
    );
  }
}

class MarkModelList {
  final List<MarkModel> list;

  MarkModelList({required this.list});

  factory MarkModelList.fromJson(List obs) {
    List<MarkModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => MarkModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return MarkModelList(list: list);
  }
}

class ItemMarkModel {
  final int id;
  final String mark;
  final int type;

  ItemMarkModel({required this.id, required this.mark, required this.type});

  factory ItemMarkModel.fromJson(Map<String, dynamic> json) {
    return ItemMarkModel(
      id: json['id'] ?? 0,
      mark: json['mark'] ?? '',
      type: json['type'] ?? 0,
    );
  }
}

class ItemMarkModelList {
  final List<ItemMarkModel> list;

  ItemMarkModelList({required this.list});

  factory ItemMarkModelList.fromJson(List obs) {
    List<ItemMarkModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => ItemMarkModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return ItemMarkModelList(list: list);
  }
}

class MarkUpModel {
  final String mark;
  final int subId;
  final int term;
  final int typeMark;

  MarkUpModel({
    required this.mark,
    required this.subId,
    required this.term,
    required this.typeMark,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'mark': mark,
        'subjectId': subId,
        'term': term,
        'typeMark': typeMark,
      };
}
