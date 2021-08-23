import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_presenter.dart';

class ItemPraPresenter extends Presenter {
  ItemPraPresenter(BuildContext context, Contract view, this.model, this.index)
      : super(context, view);

  //Data final.
  final QuestionModel model;
  final int index;

  String ques = '';
  String anA = '';
  String anB = '';
  String anC = '';
  String anD = '';
  String hin = '';

  //Data.
  bool isGuide = false;
  bool isAddFirst = true;
  int radioGroup = 0;
  bool isSmall = true;
  double reWidth = 500;
  String wordStart = '<tex>';
  String wordEnd = '</tex>';

  String mathS = '<math>';
  String mathE = '</math>';

  //Answer.
  double reA = 500;
  bool smallA = true;

  //Hint.
  double reH = 500;
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
    if (valueH == 40) smallH = false;
    if (valueH == 150) reH = 800;
    if (valueH == 150) smallH = false;

    int valueMH = onReSizeMath(model.hints);
    if (valueMH == 40) smallH = false;
    if (valueMH == 150) reH = 800;
    if (valueMH == 150) smallH = false;
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
  }

  void onGuide() {
    isGuide = !isGuide;
    BlocProvider.of<AuthBloc>(context).add(ClickLightEvent());
  }

  void onChange(int? value) {
    radioGroup = value!;
    BlocProvider.of<AuthBloc>(context).add(ClickRadioEvent());
    if (isAddFirst) {
      userRes.qsChoice += 1;
      BlocProvider.of<AuthBloc>(context).add(ClickQuestionEvent());
    }
    userRes.listAnswerExe.removeAt(index);
    userRes.listAnswerExe.insert(index, radioGroup);
    isAddFirst = false;
  }
}
