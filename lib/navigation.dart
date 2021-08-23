import 'auth/bloc.dart';
import 'pages/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hava/themes/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/screens/create_acc/login/login_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => current is LoginState,
        builder: (BuildContext context, AuthState state) {
          debugPrint('vao LoginState $state');
          Widget _view;
          if (state is LoginState) {
            debugPrint('vao main');
            _view = MainView();
          } else {
            debugPrint('vao login');
            _view = const LoginView();
          }
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Styles.colorMain,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                centerTitle: true,
                color: Styles.colorMain,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              scaffoldBackgroundColor: Colors.white,
              brightness: Brightness.light,
              splashColor: Colors.transparent,
            ),
            debugShowCheckedModeBanner: false,
            home: _view,
          );
        });
  }
}
