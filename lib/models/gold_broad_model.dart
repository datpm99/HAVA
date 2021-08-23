import 'package:flutter/material.dart';

class GoldBroadModel {
  final int stt;
  final int userId;
  final int examId;
  final String name;
  final double mark;
  final int minute;
  final String avatar;

  GoldBroadModel({
    required this.stt,
    required this.userId,
    required this.examId,
    required this.name,
    required this.mark,
    required this.minute,
    required this.avatar,
  });

  factory GoldBroadModel.fromJson(Map<String, dynamic> json) {
    return GoldBroadModel(
      stt: json['stt'] ?? 0,
      userId: json['userId'] ?? 0,
      examId: json['examId'] ?? 0,
      name: json['name'] ?? '',
      mark: json['mark'] ?? 0,
      minute: json['minute'] ?? 0,
      avatar: json['avata'] ?? '',
    );
  }
}

class GoldBroadModelList {
  final List<GoldBroadModel> list;

  GoldBroadModelList({required this.list});

  factory GoldBroadModelList.fromJson(List obs) {
    List<GoldBroadModel> list = [];
    try {
      if (obs.isNotEmpty) {
        list = obs.map((e) => GoldBroadModel.fromJson(e)).toList();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }

    return GoldBroadModelList(list: list);
  }
}
