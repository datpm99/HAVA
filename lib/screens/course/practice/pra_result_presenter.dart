import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/themes/styles.dart';

class PraResultPresenter extends Presenter {
  PraResultPresenter(
      BuildContext context, Contract view, this.model, this.index)
      : super(context, view);

  //Data Final.
  final QuestionModel model;
  final int index;

  String ques = '';
  String anA = '';
  String anB = '';
  String anC = '';
  String anD = '';
  String hin = '';
  String anw = '';
  String comment = '';

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
  bool isSmall = true;
  double reWidth = 600;
  String wordStart = '<tex>';
  String wordEnd = '</tex>';

  String mathS = '<math xmlns="http://www.w3.org/1998/Math/MathML">';
  String mathE = '</math>';

  //Answer.
  double reA = 600;
  bool smallA = true;

  //Hint.
  double reH = 710;
  bool smallH = true;

  @override
  void init() {
    super.init();
    replaceMath();
    //Resize Question.
    int valueQues = onReSizeQues(model.question);
    if (valueQues == 40) isSmall = false;
    if (valueQues == 150) reWidth = 800;
    if (valueQues == 150) isSmall = false;

    int valueM = onReSizeMath(model.question);
    if (valueM == 40) isSmall = false;
    if (valueM == 150) reWidth = 800;
    if (valueM == 150) isSmall = false;

    //Resize Answer.
    int valueA = onReSizeQues(model.answerA);
    if (valueA == 40) smallA = false;
    if (valueA == 150) smallA = false;
    if (valueA == 150) reA = 800;

    int valueMA = onReSizeMath(model.answerA);
    if (valueMA == 40) smallA = false;
    if (valueMA == 150) reA = 800;
    if (valueMA == 150) smallA = false;

    int valueB = onReSizeQues(model.answerB);
    if (valueB == 40) smallA = false;
    if (valueB == 150) smallA = false;
    if (valueB == 150) reA = 800;

    int valueMB = onReSizeMath(model.answerB);
    if (valueMB == 40) smallA = false;
    if (valueMB == 150) reA = 800;
    if (valueMB == 150) smallA = false;

    int valueC = onReSizeQues(model.answerC);
    if (valueC == 40) smallA = false;
    if (valueC == 150) smallA = false;
    if (valueC == 150) reA = 800;

    int valueMC = onReSizeMath(model.answerC);
    if (valueMC == 40) smallA = false;
    if (valueMC == 150) reA = 800;
    if (valueMC == 150) smallA = false;

    int valueD = onReSizeQues(model.answerD);
    if (valueD == 40) smallA = false;
    if (valueD == 150) smallA = false;
    if (valueD == 150) reA = 800;

    int valueMD = onReSizeMath(model.answerD);
    if (valueMD == 40) smallA = false;
    if (valueMD == 150) reA = 800;
    if (valueMD == 150) smallA = false;

    //Resize Hint.
    int valueH = onReSizeQues(model.hints);
    int valueAnw = onReSizeQues(model.answer);
    int valueCom = onReSizeQues(model.comments);

    if (valueH == 40 || valueAnw == 40 || valueCom == 40) smallH = false;
    if (valueH == 150 || valueAnw == 150 || valueCom == 150) smallH = false;
    if (valueH == 150 || valueAnw == 150 || valueCom == 150) reH = 800;

    //Math
    int valueMH = onReSizeMath(model.hints);
    int valueMAnw = onReSizeMath(model.answer);
    int valueMCom = onReSizeMath(model.comments);

    print('$valueMH -- $valueMAnw -- $valueMCom');

    if (valueMH == 40 || valueMAnw == 40 || valueMCom == 40) smallH = false;
    if (valueMH == 150 || valueMAnw == 150 || valueMCom == 150) smallH = false;
    if (valueMH == 150 || valueMAnw == 150 || valueMCom == 150) reH = 800;

    hint = anw;
    if (userRes.listAnswerExe[index] == userRes.listAnswerResult[index]) {
      changeColorRight();
      changeColorCircleRight();
    } else {
      changeColorRight();
      changeColorWrong();
      changeColorCircleWrong();
    }
  }

  int onReSizeQues(String txt) {
    List<int> listStart = [];
    List<int> listEnd = [];
    int value = 0;
    int value150 = 0;
    for (int i = -1; (i = txt.indexOf(wordStart, i + 1)) != -1; i++) {
      listStart.add(i);
    }

    for (int i = -1; (i = txt.indexOf(wordEnd, i + 1)) != -1; i++) {
      listEnd.add(i);
    }

    for (int i = 0; i < listStart.length; i++) {
      String abc = txt.substring(listStart[i] + 5, listEnd[i]);
      if (abc.length > 40) value = 40;
      if (abc.length > 150) value150 = 150;
    }
    if (value150 == 150) value = 150;
    return value;
  }

  int onReSizeMath(String txt) {
    List<int> listStart = [];
    List<int> listEnd = [];
    int value = 0;
    int value150 = 0;
    for (int i = -1; (i = txt.indexOf(mathS, i + 1)) != -1; i++) {
      listStart.add(i);
    }

    for (int i = -1; (i = txt.indexOf(mathE, i + 1)) != -1; i++) {
      listEnd.add(i);
    }

    for (int i = 0; i < listStart.length; i++) {
      String abc = txt.substring(listStart[i] + 5, listEnd[i]);
      if (abc.length > 300) value = 40;
      if (abc.length > 500) value150 = 150;
    }
    if (value150 == 150) value = 150;
    return value;
  }

  void replaceMath() {
    ques = model.question;
    anA = model.answerA;
    anB = model.answerB;
    anC = model.answerC;
    anD = model.answerD;
    hin = model.hints;
    anw = model.answer;
    comment = model.comments;
    ques = ques.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    ques = ques.replaceAll("^'", "'^");
    anA = anA.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    anA = anA.replaceAll("^'", "'^");
    anB = anB.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    anB = anB.replaceAll("^'", "'^");
    anC = anC.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    anC = anC.replaceAll("^'", "'^");
    anD = anD.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    anD = anD.replaceAll("^'", "'^");
    hin = hin.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    hin = hin.replaceAll("^'", "'^");
    anw = anw.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    anw = anw.replaceAll("^'", "'^");
    comment = comment.replaceAll('^\\sqrt2', '^{\\sqrt{2}}');
    comment = comment.replaceAll("^'", "'^");
  }

  void changeColorRight() {
    if (userRes.listAnswerResult[index] == 1) colorA = Styles.colorGreen1;
    if (userRes.listAnswerResult[index] == 2) colorB = Styles.colorGreen1;
    if (userRes.listAnswerResult[index] == 3) colorC = Styles.colorGreen1;
    if (userRes.listAnswerResult[index] == 4) colorD = Styles.colorGreen1;
  }

  void changeColorWrong() {
    if (userRes.listAnswerExe[index] == 1) colorA = Styles.colorRed2;
    if (userRes.listAnswerExe[index] == 2) colorB = Styles.colorRed2;
    if (userRes.listAnswerExe[index] == 3) colorC = Styles.colorRed2;
    if (userRes.listAnswerExe[index] == 4) colorD = Styles.colorRed2;
  }

  void changeColorCircleRight() {
    if (userRes.listAnswerResult[index] == 1) colorCircleA = Styles.colorGreen1;
    if (userRes.listAnswerResult[index] == 2) colorCircleB = Styles.colorGreen1;
    if (userRes.listAnswerResult[index] == 3) colorCircleC = Styles.colorGreen1;
    if (userRes.listAnswerResult[index] == 4) colorCircleD = Styles.colorGreen1;
  }

  void changeColorCircleWrong() {
    if (userRes.listAnswerExe[index] == 1) colorCircleA = Styles.colorRed2;
    if (userRes.listAnswerExe[index] == 2) colorCircleB = Styles.colorRed2;
    if (userRes.listAnswerExe[index] == 3) colorCircleC = Styles.colorRed2;
    if (userRes.listAnswerExe[index] == 4) colorCircleD = Styles.colorRed2;
  }

  void onChangeGuide(int type) {
    if (type == 1) {
      hint = hin;
      colorGuide = Styles.colorG10;
      colorAnswer = Styles.colorG7;
      colorComment = Styles.colorG7;
    } else if (type == 2) {
      hint = anw;
      colorGuide = Styles.colorG7;
      colorAnswer = Styles.colorG10;
      colorComment = Styles.colorG7;
    } else {
      hint = comment;
      colorGuide = Styles.colorG7;
      colorAnswer = Styles.colorG7;
      colorComment = Styles.colorG10;
    }
    view.updateState();
  }
}
