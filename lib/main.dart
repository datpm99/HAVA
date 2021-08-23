import 'dart:io';
import 'auth/bloc.dart';
import 'navigation.dart';
import 'models/user_model.dart';
import 'package:hive/hive.dart';
import 'auth/app_repository.dart';
import 'package:flutter/material.dart';
import 'helper/local_notification_plugin.dart';
import 'screens/ques_hive/ques_model.dart';
import 'screens/remind/model/remind_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDirectory = await getApplicationDocumentsDirectory();
  Directory directory = await Directory(appDocDirectory.path + '/' + 'dir')
      .create(recursive: true);
  Hive
    ..init(directory.path)
    ..registerAdapter(RemindModelAdapter())
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(QuesModelAdapter())
    ..registerAdapter(QuestionModelAdapter());
  UserRepository userRes = UserRepository();
  await userRes.init();
  await LocalNotificationPlugin().init();
  runApp(
    RepositoryProvider(
      create: (context) => userRes,
      child: BlocProvider(
        create: (BuildContext context) =>
            AuthBloc(context, userRes)..add(AppStartedEvent()),
        child: const MyApp(),
      ),
    ),
  );
}
