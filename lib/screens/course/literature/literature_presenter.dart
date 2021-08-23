import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/screens/course/literature/lit_result_view.dart';
import 'package:hava/screens/dialog/alert_result_dialog.dart';
import 'package:hava/src/lib_presenter.dart';
import 'item_literature_view.dart';

class LiteraturePresenter extends Presenter {
  LiteraturePresenter(
      BuildContext context, Contract view, this.listQuestion, this.isIdExam)
      : super(context, view);

  final List listQuestion;
  final int isIdExam;

  //CountDownTimer
  Timer? timer;
  int minute = 120;
  int second = 60;
  String minuteShow = '120';
  String secondShow = '00';

  //
  int numQues = 0;
  int indexNum = 0;
  bool isSubmit = false;
  String titleAppbar = 'Luyện đề';
  bool showLight = true;

  @override
  void loadData() {
    super.loadData();
    countDownTime();
    list = listQuestion;
    for (int i = 0; i < list.length; i++) {
      QuestionModel model = list[i];
      if (model.answerA.isNotEmpty) numQues++;
    }
    if (isIdExam == 1) {
      titleAppbar = 'Luyện thi';
      showLight = false;
    }
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      QuestionModel model = list[index];
      if (model.answerA.isNotEmpty) indexNum++;
      if (!isSubmit) {
        return ItemLiteratureView(
            model: model, index: indexNum, showLight: showLight);
      } else {
        return LitResultView(model: model, index: indexNum);
      }
    }
    return super.itemBuild(context, index);
  }

  void countDownTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minute == 0 && second == 0) {
        onOK();
      } else {
        if (minute == 120) {
          minute--;
          minuteShow = '$minute';
        }
        if (second == 0) {
          minute--;
          second = 60;
          if (minute < 10) minuteShow = '0$minute';
          if (minute >= 10) minuteShow = '$minute';
        }
        second--;
        if (second < 10) secondShow = '0$second';
        if (second >= 10) secondShow = '$second';
        BlocProvider.of<AuthBloc>(context).add(CountDownTimeEvent());
      }
    });
  }

  void dialogShowNotify(String name, Function() onTap) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
            title: 'Lời nhắc', content: name, cancel: onBack, ok: onTap);
      },
    );
  }

  void onOK() {
    indexNum = 0;
    timer!.cancel();
    isSubmit = true;
    view.updateState();
  }

  void dialogSubmit() {
    onBack();
    onOK();
  }

  void onSubmit() {
    if (minute != 0) dialogShowNotify(Utils.notify2, dialogSubmit);
  }

  void on2Back() {
    onBack();
    onBack();
  }

  void onBackExam() {
    if (isSubmit) onBack();
    if (!isSubmit) dialogShowNotify(Utils.notify7, on2Back);
  }

  Future<bool> onWillPopBack() async {
    if (!isSubmit) {
      return (await showDialog(
        context: context,
        builder: (_) {
          return AlertResultDialog(
            title: 'Lời nhắc',
            content: Utils.notify7,
            cancel: onBack,
            ok: on2Back,
          );
        },
      ));
    }
    return true;
  }
}
