import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initialized extends AuthState {
  @override
  String toString() {
    return 'Initialized';
  }
}

class ClickQuestionState extends AuthState {
  @override
  String toString() {
    return 'ClickQuestionState';
  }
}

class CountDownTimeState extends AuthState {
  @override
  String toString() {
    return 'CountDownTimeState';
  }
}

class ClickRadioState extends AuthState {
  @override
  String toString() {
    return 'ClickRadioState';
  }
}

class ClickLightState extends AuthState {
  @override
  String toString() {
    return 'ClickLightState';
  }
}

class ClickTabBarState extends AuthState {
  @override
  String toString() {
    return 'ClickTabBarState';
  }
}

//English State.
class ClickQuesEngState extends AuthState {
  @override
  String toString() {
    return 'ClickQuesEngState';
  }
}

class CDTimeEngState extends AuthState {
  @override
  String toString() {
    return 'CDTimeEngState';
  }
}

//Event CountDownTime ExamSchedule.
class CDExamScheduleState extends AuthState {
  @override
  String toString() {
    return 'CDExamScheduleState';
  }
}

class CDDetailScheduleState extends AuthState {
  @override
  String toString() {
    return 'CDDetailScheduleState';
  }
}

class LoginState extends AuthState {
  @override
  String toString() {
    return 'LoginState';
  }
}

class LogoutState extends AuthState {
  @override
  String toString() {
    return 'LogoutState';
  }
}
