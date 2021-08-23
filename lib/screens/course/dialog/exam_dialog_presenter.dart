import 'package:hava/screens/course/english/english_view.dart';
import 'package:hava/screens/course/literature/literature_view.dart';
import 'package:hava/screens/course/practice/practice_view.dart';
import 'package:hava/screens/ques_hive/ques_hive.dart';
import 'package:hava/src/lib_presenter.dart';
import '../course_api_client.dart';

class ExamDialogPresenter extends Presenter {
  ExamDialogPresenter(
      BuildContext context, Contract view, this.idSub, this.idExam)
      : super(context, view);

  //Final Data.
  final int idSub, idExam;
  late CourseApiClient _apiClient;
  late QuesHive _quesHive;

  @override
  void init() async {
    super.init();
    _apiClient = CourseApiClient(context);
    _quesHive = QuesHive();
  }

  void onPractice(int id) async {
    loadingData(Const.loadingData1);
    bool isSaveExam = false;
    if (idSub == 1) isSaveExam = await _quesHive.checkExamSave(id);
    if (isSaveExam) {
      //Exam already save in mobile.
      list = await _quesHive.getExam(id);
      await decodeHtml(list);
      onNavigatorExam(id);
    } else {
      //Exam not save in mobile.
      list = await _apiClient.getQuestion(id);
      await decodeHtml(list);
      if (idSub == 1) await _quesHive.addExam(userRes.listQuesHive, id);
      onNavigatorExam(id);
    }
  }

  void onNavigatorExam(int id) {
    if (idSub == 9) {
      onBack();
      Utils.navigatePage(
        context,
        LiteratureView(idExam: id, listQuestion: list, isIdExam: idExam),
      );
    } else if (idSub == 5) {
      onBack();
      Utils.navigatePage(
        context,
        EnglishView(
            listQues: list,
            idExam: id,
            isIdExam: idExam,
            idHis: 0,
            idSchedule: 0),
      );
    } else {
      String nameSub = Utils.listSubDoc[idSub - 1];
      String timeSub = Utils.listTimeSub[idSub - 1];
      onBack();
      Utils.navigatePage(
        context,
        PracticeView(
          idExam: id,
          listQuestion: list,
          isIdExam: idExam,
          nameSubject: nameSub,
          timeSub: timeSub,
          idHis: 0,
          idSchedule: 0,
          idSub: idSub,
        ),
      );
    }
  }

  void onCheckActive(int isFree, int id) {
    bool isActive = checkSubActive(idSub);
    if (isActive) {
      onPractice(id);
    } else {
      if (isFree == 1) {
        onPractice(id);
      } else {
        onActive();
      }
    }
  }
}
