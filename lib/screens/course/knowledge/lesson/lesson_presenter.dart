import 'package:hava/screens/course/knowledge/less_final/item_less_final_view.dart';
import 'package:hava/screens/ques_hive/ques_hive.dart';
import 'package:hava/src/lib_exam.dart';
import 'package:hava/src/lib_presenter.dart';
import '../item_knowledge_view.dart';

class LessonPresenter extends Presenter {
  LessonPresenter(
      BuildContext context, Contract view, this.listKnow, this.sub, this.idSub)
      : super(context, view);

  //Data Final.
  final List listKnow;
  final String sub;
  final int idSub;
  late CourseApiClient _courseApiClient;
  late QuesHive _quesHive;

  @override
  void init() {
    super.init();
    _courseApiClient = CourseApiClient(context);
    _quesHive = QuesHive();
  }

  @override
  void loadData() {
    super.loadData();
    list = listKnow;
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      KnowModel model = list[index];
      if (model.content.isEmpty && model.examId == 0) {
        return ItemKnowledgeView(sub: sub, model: model, idSub: idSub);
      } else {
        model.content = unescape.convert(model.content);
        return ItemLessFinalView(model: model, onExam: onCheckActive);
      }
    }
    return super.itemBuild(context, index);
  }

  void onQuestion(int id) async {
    loadingData(Const.loadingData2);
    bool isSaveExam = false;
    if (idSub == 1) isSaveExam = await _quesHive.checkExamSave(id);
    if (isSaveExam) {
      //Exam already save in mobile.
      List listQues = await _quesHive.getExam(id);
      await decodeHtml(list);
      onBack();
      onNavigatorExam(id, listQues);
    } else {
      //Exam not save in mobile.
      List listQues = await _courseApiClient.getQuestion(id);
      await decodeHtml(listQues);
      if (idSub == 1) await _quesHive.addExam(userRes.listQuesHive, id);
      onBack();
      onNavigatorExam(id, listQues);
    }
  }

  void onNavigatorExam(int id, List listQ) {
    if (idSub == 5) {
      Utils.navigatePage(
        context,
        EnglishView(
          listQues: listQ,
          idExam: id,
          isIdExam: 3,
          idHis: 0,
          idSchedule: 0,
        ),
      );
    } else {
      String nameSub = sub;
      String timeSub = '180';
      Utils.navigatePage(
        context,
        PracticeView(
          idExam: id,
          listQuestion: listQ,
          isIdExam: 3,
          nameSubject: nameSub,
          timeSub: timeSub,
          idHis: 0,
          idSchedule: 0,
          idSub: idSub,
        ),
      );
    }
  }

  void onCheckActive(int id) {
    bool isActive = checkSubActive(idSub);
    if (isActive) {
      onQuestion(id);
    } else {
      onActive();
    }
  }
}
