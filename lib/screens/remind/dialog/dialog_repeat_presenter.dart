import 'package:hava/src/lib_presenter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hava/helper/local_notification_plugin.dart';
import 'package:hava/screens/remind/model/remind_hive.dart';
import 'package:hava/screens/remind/model/remind_model.dart';

class DialogRepeatPresenter extends Presenter {
  DialogRepeatPresenter(BuildContext context, Contract view, this.listBox,
      this.timeAdd, this.idAdd, this.idUpdate, this.titleUpdate)
      : super(context, view);

  final List<int> listBox;
  final String timeAdd;
  final int idAdd;
  final int idUpdate;
  final String titleUpdate;
  TextEditingController editingController = TextEditingController();
  List<int> listBoxNew = [];
  late RemindHive _remindHive;

  @override
  void init() {
    super.init();
    _remindHive = RemindHive();
  }

  @override
  void loadData() {
    super.loadData();
    for (int i = 0; i < listBox.length; i++) {
      if (listBox[i] == 1) mon = true;
      if (listBox[i] == 2) tue = true;
      if (listBox[i] == 3) wed = true;
      if (listBox[i] == 4) thu = true;
      if (listBox[i] == 5) fri = true;
      if (listBox[i] == 6) sat = true;
      if (listBox[i] == 7) sun = true;
    }
    if (titleUpdate.isNotEmpty) {
      editingController.text = titleUpdate;
    }
    view.updateState();
  }

//Bool Day Of Week.
  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;

//OnChange Bool Day.
  onMon(value) {
    mon = value;
    view.updateState();
  }

  onTue(value) {
    tue = value;
    view.updateState();
  }

  onWed(value) {
    wed = value;
    view.updateState();
  }

  onThu(value) {
    thu = value;
    view.updateState();
  }

  onFri(value) {
    fri = value;
    view.updateState();
  }

  onSat(value) {
    sat = value;
    view.updateState();
  }

  onSun(value) {
    sun = value;
    view.updateState();
  }

  void checkListBox() {
    if (mon == true) listBoxNew.add(1);
    if (tue == true) listBoxNew.add(2);
    if (wed == true) listBoxNew.add(3);
    if (thu == true) listBoxNew.add(4);
    if (fri == true) listBoxNew.add(5);
    if (sat == true) listBoxNew.add(6);
    if (sun == true) listBoxNew.add(7);
  }

  void checkListNof(String title, int id, String timeTxt) {
    int hour = int.parse(timeTxt.substring(0, 2));
    int minute = int.parse(timeTxt.substring(3, 5));
    Time time = Time(hour, minute, 0);
    if (mon == true) buildNotification(title, Day.monday, time, id + 1000);
    if (tue == true) buildNotification(title, Day.tuesday, time, id + 2000);
    if (wed == true) buildNotification(title, Day.wednesday, time, id + 3000);
    if (thu == true) buildNotification(title, Day.thursday, time, id + 4000);
    if (fri == true) buildNotification(title, Day.friday, time, id + 5000);
    if (sat == true) buildNotification(title, Day.saturday, time, id + 6000);
    if (sun == true) buildNotification(title, Day.sunday, time, id + 7000);
    print('Add Notification ');
  }

  void onOk() async {
    checkListBox();
    if (editingController.text.isEmpty) {
      Utils.showToast('Tiêu đề không được để trống!');
    } else if (listBoxNew.isEmpty) {
      Utils.showToast('Em phải chọn một ngày để đặt lời nhắc!');
    } else {
      if (timeAdd.isNotEmpty) {
        String titleAdd = editingController.text;
        //checkListBox();
        checkListNof(titleAdd, idAdd, timeAdd);
        RemindModel modelR = RemindModel(
          id: idAdd,
          time: timeAdd,
          isDefault: false,
          isAlarm: true,
          title: titleAdd,
          listRepeat: listBoxNew,
        );
        await _remindHive.addReminder(modelR);
        onBack();
      } else {
        //checkListBox();
        String titleUpdate = editingController.text;
        await _remindHive.updateBoxReminder(idUpdate, titleUpdate, listBoxNew);
        onBack();
      }
    }
  }

  buildNotification(String title, Day day, Time time, int id) async {
    LocalNotificationPlugin().showWeeklyAtDayAndTime(title, day, time, id);
  }
}
