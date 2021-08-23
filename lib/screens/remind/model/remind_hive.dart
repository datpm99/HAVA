import 'package:flutter/material.dart';
import 'package:hava/screens/remind/model/remind_model.dart';
import 'package:hive/hive.dart';

class RemindHive {
  Box? box;
  static const String _reminderKey = 'reminderKey';

  RemindHive() {
    initHive();
  }

  void initHive() async {
    box = await Hive.openBox(_reminderKey);
  }

  void clearBox() async {
    if(box==null) await Hive.openBox(_reminderKey);
    box!.clear();
    debugPrint('Clear Box Success!');
  }

  Future addReminder(RemindModel model) async {
    if(box==null) await Hive.openBox(_reminderKey);
    box!.add(model);
    debugPrint('Add Reminder Success!');
  }

  Future<List> getReminder() async {
    if(box==null) await Hive.openBox(_reminderKey);
    debugPrint('Get List Reminder Success!');
    return box!.values.toList();
  }

  Future updateTimeReminder(int id, String time) async {
    if(box==null) await Hive.openBox(_reminderKey);
    var list = box!.values.toList();
    for (int i = 0; i < list.length; i++) {
      var item = list[i];
      if (item.id == id) {
        item.time = time;
        item.save();
        break;
      }
    }
    debugPrint('Update TimeReminder Success!');
  }

  Future updateBoxReminder(int id, String title, List<int> listBox) async {
    if(box==null) await Hive.openBox(_reminderKey);
    var list = box!.values.toList();
    for (int i = 0; i < list.length; i++) {
      var item = list[i];
      if (item.id == id) {
        item.title = title;
        item.listRepeat = listBox;
        item.save();
        break;
      }
    }
    debugPrint('Update BoxReminder Success!');
  }

  Future updateAlarmReminder(int id, bool bolAlarm) async {
    if(box==null) await Hive.openBox(_reminderKey);
    var list = box!.values.toList();
    for (int i = 0; i < list.length; i++) {
      var item = list[i];
      if (item.id == id) {
        item.isAlarm = bolAlarm;
        item.save();
        break;
      }
    }
    debugPrint('Update Alarm Reminder Success!');
  }

  Future deleteReminderById(int id) async {
    if(box==null) await Hive.openBox(_reminderKey);
    var list = box!.values.toList();
    for (int i = 0; i < list.length; i++) {
      var item = list[i];
      if (item.id == id) {
        box!.deleteAt(i);
        break;
      }
    }
    debugPrint('Delete Reminder Success!');
  }
}
