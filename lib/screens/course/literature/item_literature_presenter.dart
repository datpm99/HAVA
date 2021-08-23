import 'package:hava/models/question_model.dart';
import 'package:hava/src/lib_presenter.dart';

class ItemLiteraturePresenter extends Presenter {
  ItemLiteraturePresenter(
      BuildContext context, Contract view, this.model, this.index)
      : super(context, view);

  //DataFinal
  final QuestionModel model;
  final int index;
  bool isGuide = false;
  String titleQues = '';

  @override
  void loadData() {
    super.loadData();
    if (model.answerA.isNotEmpty) titleQues = 'Câu $index:';
    view.updateState();
  }

  void onGuide() {
    isGuide = !isGuide;
    view.updateState();
  }
}
