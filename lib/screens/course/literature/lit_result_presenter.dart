import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/themes/styles.dart';

class LitResultPresenter extends Presenter {
  LitResultPresenter(
      BuildContext context, Contract view, this.model, this.index)
      : super(context, view);

  //Data Final.
  final QuestionModel model;
  final int index;
  String nameGuide = '';
  Color colorSol = Styles.colorWhile;
  Color colorGui = Styles.colorG10;
  String titleQues = '';

  @override
  void loadData() {
    super.loadData();
    if (model.answerA.isNotEmpty) titleQues = 'Câu $index:';
    onResult(2);
  }

  void onResult(int type) {
    if (type == 1) {
      nameGuide = model.hints;
      colorGui = Styles.colorG10;
      colorSol = Styles.colorWhile;
    } else {
      nameGuide = model.answer;
      colorSol = Styles.colorG10;
      colorGui = Styles.colorWhile;
    }
    view.updateState();
  }
}
