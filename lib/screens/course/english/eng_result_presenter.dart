import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/src/lib_view.dart';

class EngResultPresenter extends Presenter {
  EngResultPresenter(BuildContext context, Contract view, this.model, this.index)
      : super(context, view);

  final QuestionModel model;
  final int index;

  String get question => model.question;

  String get valueLable => model.valueLable;

  String get answerA => model.answerA;

  String get answerB => model.answerB;

  String get answerC => model.answerC;

  String get answerD => model.answerD;

  int get answerTrue => model.answerTrue;

  //Data.
  String hint = '';
  Color colorGuide = Styles.colorG7;
  Color colorAnswer = Styles.colorG10;
  Color colorComment = Styles.colorG7;
  Color colorA = Styles.colorB2;
  Color colorB = Styles.colorB2;
  Color colorC = Styles.colorB2;
  Color colorD = Styles.colorB2;
  Color colorCircleA = Colors.white;
  Color colorCircleB = Colors.white;
  Color colorCircleC = Colors.white;
  Color colorCircleD = Colors.white;

  @override
  void loadData() {
    super.loadData();
    hint = model.answer;
    if(index !=-1){
      if(userRes.listAnswerExe[index] == userRes.listAnswerResult[index]){
        changeColorRight();
        changeColorCircleRight();
      }else{
        changeColorRight();
        changeColorWrong();
        changeColorCircleWrong();
      }
    }
    view.updateState();
  }

  void changeColorRight(){
    if(userRes.listAnswerResult[index] == 1) colorA = Styles.colorGreen1;
    if(userRes.listAnswerResult[index] == 2) colorB = Styles.colorGreen1;
    if(userRes.listAnswerResult[index] == 3) colorC = Styles.colorGreen1;
    if(userRes.listAnswerResult[index] == 4) colorD = Styles.colorGreen1;
  }

  void changeColorWrong(){
    if(userRes.listAnswerExe[index] == 1) colorA = Styles.colorRed2;
    if(userRes.listAnswerExe[index] == 2) colorB = Styles.colorRed2;
    if(userRes.listAnswerExe[index] == 3) colorC = Styles.colorRed2;
    if(userRes.listAnswerExe[index] == 4) colorD = Styles.colorRed2;
  }

  void changeColorCircleRight(){
    if(userRes.listAnswerResult[index] == 1) colorCircleA = Styles.colorGreen1;
    if(userRes.listAnswerResult[index] == 2) colorCircleB = Styles.colorGreen1;
    if(userRes.listAnswerResult[index] == 3) colorCircleC = Styles.colorGreen1;
    if(userRes.listAnswerResult[index] == 4) colorCircleD = Styles.colorGreen1;
  }

  void changeColorCircleWrong(){
    if(userRes.listAnswerExe[index] == 1) colorCircleA = Styles.colorRed2;
    if(userRes.listAnswerExe[index] == 2) colorCircleB = Styles.colorRed2;
    if(userRes.listAnswerExe[index] == 3) colorCircleC = Styles.colorRed2;
    if(userRes.listAnswerExe[index] == 4) colorCircleD = Styles.colorRed2;
  }

  void onChangeGuide(int type) {
    if (type == 1) {
      hint = model.hints;
      colorGuide = Styles.colorG10;
      colorAnswer = Styles.colorG7;
      colorComment = Styles.colorG7;
    } else if (type == 2) {
      hint = model.answer;
      colorGuide = Styles.colorG7;
      colorAnswer = Styles.colorG10;
      colorComment = Styles.colorG7;
    } else {
      hint = model.comments;
      colorGuide = Styles.colorG7;
      colorAnswer = Styles.colorG7;
      colorComment = Styles.colorG10;
    }
    view.updateState();
  }
}
