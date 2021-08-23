import 'package:hava/src/lib_exam.dart';
import 'package:hava/src/lib_presenter.dart';
import 'knowledge/knowledge_view.dart';
import 'dialog/exam_dialog.dart';

class CoursePresenter extends Presenter {
  CoursePresenter(BuildContext context, Contract view, this.sub, this.id)
      : super(context, view);

  final String sub;
  final int id;
  late CourseApiClient _courseApiClient;

  //List Display Exam.
  List listEasy = [];
  List listNormal = [];
  List listHard = [];
  List listTemp = [];
  int indexHard = 0;
  ExamModel modelNull = ExamModel(
    id: 0,
    title: '',
    categoryId: 0,
    level: 10,
    isFree: 0,
    isDone: 0,
    isRandom: 0,
  );

  @override
  void init() {
    super.init();
    _courseApiClient = CourseApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    loadingData(Const.loadingData2);
    listTemp = await _courseApiClient.getExams(id);
    listEasy.add(modelNull);
    for (int i = 0; i < listTemp.length; i++) {
      ExamModel model = listTemp[i];
      if (model.level == 0) listEasy.add(model);
      if (model.level == 1) listNormal.add(model);
      if (model.level == 2) listHard.add(model);
    }
    listEasy.add(modelNull);
    listNormal.add(modelNull);
    list.addAll(listEasy);
    list.addAll(listNormal);
    indexHard = list.length - 1;
    list.addAll(listHard);
    onBack();
    view.updateState();
  }

  void showDialogExam(title, int idExam) {
    showDialog(
      context: context,
      builder: (_) {
        return ExamDialog(
          list: list,
          easy: 0,
          normal: listEasy.length - 1,
          hard: indexHard,
          onBack: onBack,
          title: title,
          idSubject: id,
          idExam: idExam,
        );
      },
    );
  }

  void onKnowledge() async {
    loadingData(Const.loadingData2);
    List listAll = [];
    List<KnowModel> listKnow = await _courseApiClient.getKnow(10 + id);
    for (int i = 0; i < listKnow.length; i++) {
      List<KnowModel> listKnowF =
          await _courseApiClient.getKnow(listKnow[i].id);
      listAll.add(listKnowF);
    }
    onBack();
    Utils.navigatePage(
      context,
      KnowledgeView(sub: sub, listAll: listAll, listKnow: listKnow, idSub: id),
    );
  }

  void rdExam(int idExam) async {
    loadingData(Const.loadingData1);
    int idRd = 0;
    List listRD = await _courseApiClient.getRdExam(id);
    QuestionModel model = listRD[0];
    idRd = model.idExam;
    await decodeHtml(listRD);

    //Send Data.
    if (id == 9) {
      onBack();
      Utils.navigatePage(
        context,
        LiteratureView(idExam: idRd, listQuestion: listRD, isIdExam: idExam),
      );
    } else if (id == 5) {
      onBack();
      Utils.navigatePage(
        context,
        EnglishView(
          listQues: listRD,
          idExam: idRd,
          isIdExam: idExam,
          idHis: 0,
          idSchedule: 0,
        ),
      );
    } else {
      String nameSub = Utils.listSubDoc[id - 1];
      String timeSub = Utils.listTimeSub[id - 1];
      onBack();
      Utils.navigatePage(
        context,
        PracticeView(
          idExam: idRd,
          listQuestion: listRD,
          isIdExam: idExam,
          nameSubject: nameSub,
          timeSub: timeSub,
          idHis: 0,
          idSchedule: 0,
          idSub: id,
        ),
      );
    }
  }

  void onPractice() {
    showDialogExam('Luyện Tập Với Bộ Đề Có Sẵn', 0);
  }

  void onPracticeRD() {
    bool isActive = checkSubActive(id);
    if (isActive) {
      rdExam(0);
    } else {
      onActive();
    }
  }

  void onExam() {
    showDialogExam('Thi Thử Với Bộ Đề Có Sẵn', 1);
  }

  void onExamRD() {
    bool isActive = checkSubActive(id);
    if (isActive) {
      rdExam(1);
    } else {
      onActive();
    }
  }
}
