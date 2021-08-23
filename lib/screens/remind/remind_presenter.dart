import 'package:hava/src/lib_presenter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hava/helper/local_notification_plugin.dart';
import 'dialog/dialog_repeat_view.dart';
import 'item_remind_view.dart';
import 'model/remind_hive.dart';
import 'model/remind_model.dart';

class RemindPresenter extends Presenter {
  RemindPresenter(BuildContext context, Contract view) : super(context, view);

  RemindHive? _remindHive;

  //TimePicker.
  TimeOfDay? picker;
  String hourFM = '';
  String timeFM = '';

  @override
  void init() {
    super.init();
    _remindHive = RemindHive();
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _remindHive!.getReminder();
    if (list.isEmpty) {
      await _remindHive!.addReminder(Utils.modelDefault1);
      list = await _remindHive!.getReminder();
    }
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      RemindModel model = list[index];
      return ItemRemindView(
        model: model,
        onAlarm: onAlarm,
        timeDetail: onTimePickerDetail,
        boxDetail: onCheckboxDetail,
        onDelete: deleteReminder,
      );
    }
    return super.itemBuild(context, index);
  }

  _showTimePicker(TimeOfDay time) async {
    picker = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    debugPrint('---${picker.toString()}---');
  }

  void formatTime(int hour, int minute) {
    if (hour < 10) {
      timeFM = '0$hour:';
    } else {
      timeFM = '$hour:';
    }
    if (minute < 10) {
      timeFM = timeFM + '0$minute';
    } else {
      timeFM = timeFM + '$minute';
    }
  }

  void addReminder() async {
    await _showTimePicker(TimeOfDay.now());
    if (picker != null) {
      formatTime(picker!.hour, picker!.minute);
      String timeUpG = '$timeFM $hourFM';
      int idAdd = list.length + 1;
      await showDialog(
          context: context,
          builder: (_) {
            return DialogRepeatView(
              listBox: Utils.listDfDay,
              timeAdd: timeUpG,
              idAdd: idAdd,
              titleUpdate: '',
              idUpdate: 0,
            );
          });
      list = await _remindHive!.getReminder();
      view.updateState();
    }
  }

  void deleteReminder(int id, List<int> listRepeat) async {
    _remindHive!.deleteReminderById(id);
    list = await _remindHive!.getReminder();
    for (int i = 0; i < listRepeat.length; i++) {
      if (listRepeat[i] == 1) LocalNotificationPlugin().cancelById(id + 1000);
      if (listRepeat[i] == 2) LocalNotificationPlugin().cancelById(id + 2000);
      if (listRepeat[i] == 3) LocalNotificationPlugin().cancelById(id + 3000);
      if (listRepeat[i] == 4) LocalNotificationPlugin().cancelById(id + 4000);
      if (listRepeat[i] == 5) LocalNotificationPlugin().cancelById(id + 5000);
      if (listRepeat[i] == 6) LocalNotificationPlugin().cancelById(id + 6000);
      if (listRepeat[i] == 7) LocalNotificationPlugin().cancelById(id + 7000);
    }
    debugPrint('Delete Notification');
    view.updateState();
  }

  void onTimePickerDetail(RemindModel model) async {
    int hour = int.parse(model.time.substring(0, 2));
    int minute = int.parse(model.time.substring(3, 5));
    TimeOfDay timeDetail = TimeOfDay(hour: hour, minute: minute);
    await _showTimePicker(timeDetail);
    if (picker != null) {
      formatTime(picker!.hour, picker!.minute);
      String timeUpG = '$timeFM $hourFM';
      await _remindHive!.updateTimeReminder(model.id, timeUpG);
      if (model.isAlarm) {
        updateNof(model);
      }
      view.updateState();
    }
  }

  void onCheckboxDetail(RemindModel model) async {
    List listOld = model.listRepeat;
    await showDialog(
        context: context,
        builder: (_) {
          return DialogRepeatView(
            listBox: model.listRepeat,
            idUpdate: model.id,
            titleUpdate: model.title,
            idAdd: 0,
            timeAdd: '',
          );
        });
    if (model.isAlarm) {
      updateRepeat(model, listOld);
    }
    view.updateState();
  }

  //Notification.

  void updateNof(RemindModel model) {
    int hour = int.parse(model.time.substring(0, 2));
    int minute = int.parse(model.time.substring(3, 5));
    Time time = Time(hour, minute, 0);
    List listRepeat = model.listRepeat;
    for (int i = 0; i < listRepeat.length; i++) {
      if (listRepeat[i] == 1) {
        LocalNotificationPlugin().cancelById(model.id + 1000);
        buildNotification(model.title, Day.monday, time, model.id + 1000);
      }
      if (listRepeat[i] == 2) {
        LocalNotificationPlugin().cancelById(model.id + 2000);
        buildNotification(model.title, Day.tuesday, time, model.id + 2000);
      }
      if (listRepeat[i] == 3) {
        LocalNotificationPlugin().cancelById(model.id + 3000);
        buildNotification(model.title, Day.wednesday, time, model.id + 3000);
      }
      if (listRepeat[i] == 4) {
        LocalNotificationPlugin().cancelById(model.id + 4000);
        buildNotification(model.title, Day.thursday, time, model.id + 4000);
      }
      if (listRepeat[i] == 5) {
        LocalNotificationPlugin().cancelById(model.id + 5000);
        buildNotification(model.title, Day.friday, time, model.id + 5000);
      }
      if (listRepeat[i] == 6) {
        LocalNotificationPlugin().cancelById(model.id + 6000);
        buildNotification(model.title, Day.saturday, time, model.id + 6000);
      }
      if (listRepeat[i] == 7) {
        LocalNotificationPlugin().cancelById(model.id + 7000);
        buildNotification(model.title, Day.sunday, time, model.id + 7000);
      }
    }
  }

  void updateRepeat(RemindModel model, List boxOld){
    int hour = int.parse(model.time.substring(0, 2));
    int minute = int.parse(model.time.substring(3, 5));
    Time time = Time(hour, minute, 0);
    List listRepeat = model.listRepeat;
    for (int i = 0; i < boxOld.length; i++) {
      if (boxOld[i] == 1) {
        LocalNotificationPlugin().cancelById(model.id + 1000);
      }
      if (boxOld[i] == 2) {
        LocalNotificationPlugin().cancelById(model.id + 2000);
      }
      if (boxOld[i] == 3) {
        LocalNotificationPlugin().cancelById(model.id + 3000);
      }
      if (boxOld[i] == 4) {
        LocalNotificationPlugin().cancelById(model.id + 4000);
      }
      if (boxOld[i] == 5) {
        LocalNotificationPlugin().cancelById(model.id + 5000);
      }
      if (boxOld[i] == 6) {
        LocalNotificationPlugin().cancelById(model.id + 6000);
      }
      if (boxOld[i] == 7) {
        LocalNotificationPlugin().cancelById(model.id + 7000);
      }
    }
    for (int i = 0; i < listRepeat.length; i++) {
      if (listRepeat[i] == 1) {
        buildNotification(model.title, Day.monday, time, model.id + 1000);
      }
      if (listRepeat[i] == 2) {
        buildNotification(model.title, Day.tuesday, time, model.id + 2000);
      }
      if (listRepeat[i] == 3) {
        buildNotification(model.title, Day.wednesday, time, model.id + 3000);
      }
      if (listRepeat[i] == 4) {
        buildNotification(model.title, Day.thursday, time, model.id + 4000);
      }
      if (listRepeat[i] == 5) {
        buildNotification(model.title, Day.friday, time, model.id + 5000);
      }
      if (listRepeat[i] == 6) {
        buildNotification(model.title, Day.saturday, time, model.id + 6000);
      }
      if (listRepeat[i] == 7) {
        buildNotification(model.title, Day.sunday, time, model.id + 7000);
      }
    }
  }

  buildNotification(String title, Day day, Time time, int id) async {
    LocalNotificationPlugin().showWeeklyAtDayAndTime(title, day, time, id);
  }

  void onAlarm(int id, List<int> listRepeat, String timeTxt, String title,
      bool bolAlarm) async {
    if (bolAlarm) {
      int hour = int.parse(timeTxt.substring(0, 2));
      int minute = int.parse(timeTxt.substring(3, 5));
      Time time = Time(hour, minute, 0);
      for (int i = 0; i < listRepeat.length; i++) {
        if (listRepeat[i] == 1) {
          buildNotification(title, Day.monday, time, id + 1000);
        }
        if (listRepeat[i] == 2) {
          buildNotification(title, Day.tuesday, time, id + 2000);
        }
        if (listRepeat[i] == 3) {
          buildNotification(title, Day.wednesday, time, id + 3000);
        }
        if (listRepeat[i] == 4) {
          buildNotification(title, Day.thursday, time, id + 4000);
        }
        if (listRepeat[i] == 5) {
          buildNotification(title, Day.friday, time, id + 5000);
        }
        if (listRepeat[i] == 6) {
          buildNotification(title, Day.saturday, time, id + 6000);
        }
        if (listRepeat[i] == 7) {
          buildNotification(title, Day.sunday, time, id + 7000);
        }
      }
      await _remindHive!.updateAlarmReminder(id, bolAlarm);
    } else {
      for (int i = 0; i < listRepeat.length; i++) {
        if (listRepeat[i] == 1) LocalNotificationPlugin().cancelById(id + 1000);
        if (listRepeat[i] == 2) LocalNotificationPlugin().cancelById(id + 2000);
        if (listRepeat[i] == 3) LocalNotificationPlugin().cancelById(id + 3000);
        if (listRepeat[i] == 4) LocalNotificationPlugin().cancelById(id + 4000);
        if (listRepeat[i] == 5) LocalNotificationPlugin().cancelById(id + 5000);
        if (listRepeat[i] == 6) LocalNotificationPlugin().cancelById(id + 6000);
        if (listRepeat[i] == 7) LocalNotificationPlugin().cancelById(id + 7000);
      }
      await _remindHive!.updateAlarmReminder(id, bolAlarm);
      print('Delete Notification');
    }
  }
}
