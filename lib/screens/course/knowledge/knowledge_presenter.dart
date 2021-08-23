import 'package:hava/screens/ques_hive/ques_hive.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/src/lib_exam.dart';

class KnowledgePresenter extends Presenter {
  KnowledgePresenter(BuildContext context, Contract view, this.sub, this.idSub)
      : super(context, view);

  //Data final.
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

  void onQuestion(int id) async {
    loadingData(Const.loadingData2);
    bool isSaveExam = false;
    if (idSub == 1) isSaveExam = await _quesHive.checkExamSave(id);
    if (isSaveExam) {
      //Exam already save in mobile.
      list = await _quesHive.getExam(id);
      await decodeHtml(list);
      onBack();
      onNavigatorExam(id);
    } else {
      //Exam not save in mobile.
      list = await _courseApiClient.getQuestion(id);
      await decodeHtml(list);
      if (idSub == 1) await _quesHive.addExam(userRes.listQuesHive, id);
      onBack();
      onNavigatorExam(id);
    }
  }

  void onNavigatorExam(int id) {
    if (idSub == 5) {
      Utils.navigatePage(
        context,
        EnglishView(
          listQues: list,
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
          listQuestion: list,
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

  //Check Active.
  void onAc(int id) {
    bool isActive = checkSubActive(idSub);
    if (isActive) {
      onQuestion(id);
    } else {
      onActive();
    }
  }
}
