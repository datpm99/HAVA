import 'package:equatable/equatable.dart';
import 'package:hava/models/user_model.dart';

class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AuthEvent {
  @override
  String toString() {
    return 'AppStarted';
  }
}

class ClickQuestionEvent extends AuthEvent {}

class CountDownTimeEvent extends AuthEvent {}

class ClickRadioEvent extends AuthEvent {}

class ClickLightEvent extends AuthEvent {}

class ClickTabBarEvent extends AuthEvent {}

//Event English.
class ClickQuesEngEvent extends AuthEvent {}

class CDTimeEngEvent extends AuthEvent {}

//Event CountDownTime ExamSchedule.
class CDExamScheduleEvent extends AuthEvent {}

class CDDetailScheduleEvent extends AuthEvent {}

//Event Login.
class LoginEvent extends AuthEvent {
  LoginEvent(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoginEvent $user';
}

class LogoutEvent extends AuthEvent {
  @override
  String toString() {
    return 'LogoutEvent';
  }
}
