import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationPlugin {
  static final LocalNotificationPlugin _singleton =
  LocalNotificationPlugin._internal();

  factory LocalNotificationPlugin() {
    return _singleton;
  }

  LocalNotificationPlugin._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  late NotificationDetails platformChannelSpecifics;

  Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    platformChannelSpecifics = const NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
  }

  Future showWeeklyAtDayAndTime(
      String title, Day day, Time time, int id) async {
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      id,
      title,
      'Đã đến lúc học tập rồi - Hãy bắt đầu ngay nào!',
      day,
      time,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future cancelById(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
