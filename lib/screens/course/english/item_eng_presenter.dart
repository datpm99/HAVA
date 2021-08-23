import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_presenter.dart';

class ItemEngPresenter extends Presenter {
  ItemEngPresenter(BuildContext context, Contract view, this.model, this.index)
      : super(context, view);

  //Data final.
  final QuestionModel model;
  final int index;

  String get question => model.question;

  String get valueLable => model.valueLable;

  String get answerA => model.answerA;

  String get answerB => model.answerB;

  String get answerC => model.answerC;

  String get answerD => model.answerD;

  String get hint => model.hints;

  int get answerTrue => model.answerTrue;

  String get indexQues => model.index;

  //Data.
  bool isGuide = false;
  bool isAddFirst = true;
  int radioGroup = 0;


  void onGuide() {
    isGuide = !isGuide;
    view.updateState();
  }

  void onChange(int? value) {
    radioGroup = value!;
    if (isAddFirst) {
      userRes.qsChoice += 1;
      BlocProvider.of<AuthBloc>(context).add(ClickQuesEngEvent());
    }
    userRes.listAnswerExe.removeAt(index);
    userRes.listAnswerExe.insert(index, radioGroup);
    isAddFirst = false;
    view.updateState();
  }
}
