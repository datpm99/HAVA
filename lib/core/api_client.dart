import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/base/utils.dart';
import 'package:hava/screens/create_acc/login/login_view.dart';
import 'api.dart';

abstract class ApiClient {
  ApiClient(this.context) {
    init();
  }

  final BuildContext context;

  late ApiNew apiNew;
  int offset = 0;
  bool nextPage = true;
  final limit = 40;
  final limit2 = 20;
  int page = 0;

  void init() {
    apiNew = ApiNew(context);
  }

  errHandle(res) {
    // if (res.containsKey('message') && res['messsage'] != null) {
    //   throw Exception(res['message']);
    // }
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
    Utils.navigateNotBack(context, LoginView());
    throw Exception('Something wrong');
  }
}
