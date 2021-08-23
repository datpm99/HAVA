import 'bloc.dart';
import 'app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this.context,
    this.userRes,
  ) : super(Initialized()) {
    _init();
  }

  void _init() async {}

  final UserRepository userRes;
  final BuildContext context;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    debugPrint('$event');
    if (event is AppStartedEvent) {
      if (userRes.user != null) {
        yield Initialized();
        yield LoginState();
      } else {
        yield Initialized();
        yield LogoutState();
      }
    }

    if (event is LoginEvent) {
      await userRes.login(event.user);
      yield* _loginEvent(event);
    }

    if (event is LogoutEvent) {
      await userRes.logout();
      yield* _logoutEvent(event);
    }

    if (event is ClickQuestionEvent) {
      yield* _clickQuestionEvent(event);
    }
    if (event is CountDownTimeEvent) {
      yield* _countDownTimeEvent(event);
    }
    if (event is ClickRadioEvent) {
      yield* _clickRadioEvent(event);
    }
    if (event is ClickLightEvent) {
      yield* _clickLightEvent(event);
    }
    if (event is ClickTabBarEvent) {
      yield* _clickTabBarEvent(event);
    }
    if (event is ClickQuesEngEvent) {
      yield* _clickQuesEngEvent(event);
    }
    if (event is CDTimeEngEvent) {
      yield* _cDTimeEngEvent(event);
    }
    if (event is CDExamScheduleEvent) {
      yield* _cDExamScheduleEvent(event);
    }
    if (event is CDDetailScheduleEvent) {
      yield* _cDDetailScheduleEvent(event);
    }
  }

  Stream<AuthState> _loginEvent(LoginEvent event) async* {
    yield Initialized();
    yield LoginState();
  }

  Stream<AuthState> _logoutEvent(LogoutEvent event) async* {
    yield Initialized();
    yield LogoutState();
  }

  Stream<AuthState> _clickQuestionEvent(ClickQuestionEvent event) async* {
    yield Initialized();
    yield ClickQuestionState();
  }

  Stream<AuthState> _countDownTimeEvent(CountDownTimeEvent event) async* {
    yield Initialized();
    yield CountDownTimeState();
  }

  Stream<AuthState> _clickRadioEvent(ClickRadioEvent event) async* {
    yield Initialized();
    yield ClickRadioState();
  }

  Stream<AuthState> _clickLightEvent(ClickLightEvent event) async* {
    yield Initialized();
    yield ClickLightState();
  }

  Stream<AuthState> _clickTabBarEvent(ClickTabBarEvent event) async* {
    yield Initialized();
    yield ClickTabBarState();
  }

  Stream<AuthState> _clickQuesEngEvent(ClickQuesEngEvent event) async* {
    yield Initialized();
    yield ClickQuesEngState();
  }

  Stream<AuthState> _cDTimeEngEvent(CDTimeEngEvent event) async* {
    yield Initialized();
    yield CDTimeEngState();
  }

  Stream<AuthState> _cDExamScheduleEvent(CDExamScheduleEvent event) async* {
    yield Initialized();
    yield CDExamScheduleState();
  }

  Stream<AuthState> _cDDetailScheduleEvent(CDDetailScheduleEvent event) async* {
    yield Initialized();
    yield CDDetailScheduleState();
  }
}
