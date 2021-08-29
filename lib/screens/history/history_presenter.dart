import 'package:hava/screens/ques_hive/ques_hive.dart';

import 'item_history_view.dart';
import 'history_api_client.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/history_model.dart';
import 'package:hava/screens/course/course_api_client.dart';
import 'package:hava/screens/course/english/english_view.dart';
import 'package:hava/screens/course/practice/practice_view.dart';

class HistoryPresenter extends Presenter {
  HistoryPresenter(BuildContext context, Contract view) : super(context, view);

  late HistoryApiClient _historyApiClient;
  late CourseApiClient _courseApiClient;
  late QuesHive _quesHive;
  List list1 = [];
  List list2 = [];
  List list3 = [];
  List list4 = [];
  List list5 = [];
  late ScrollController controller1;
  late ScrollController controller2;
  late ScrollController controller3;
  late ScrollController controller4;
  late ScrollController controller5;
  int page1 = 0;
  int page2 = 0;
  int page3 = 0;
  int page4 = 0;
  int page5 = 0;
  bool isMore1 = true;
  bool isMore2 = true;
  bool isMore3 = true;
  bool isMore4 = true;
  bool isMore5 = true;

  //Chart.
  List<HisChart> listChart1 = [];
  List<HisChart> listChart2 = [];
  List<HisChart> listChart3 = [];
  List<HisChart> listChart4 = [];
  List<HisChart> listChart5 = [];

  @override
  void init() {
    super.init();
    _historyApiClient = HistoryApiClient(context);
    _courseApiClient = CourseApiClient(context);
    userRes.listAnswerResult = [];
    controller1 = ScrollController();
    controller2 = ScrollController();
    controller3 = ScrollController();
    controller4 = ScrollController();
    controller5 = ScrollController();
    initController(controller1, myLoadMore1);
    initController(controller2, myLoadMore2);
    initController(controller3, myLoadMore3);
    initController(controller4, myLoadMore4);
    initController(controller5, myLoadMore5);
    _quesHive = QuesHive();
  }

  @override
  void loadData() async {
    super.loadData();
    list1 = await _historyApiClient.getHistory(1, page1);
    list2 = await _historyApiClient.getHistory(2, page2);
    list3 = await _historyApiClient.getHistory(3, page3);
    list4 = await _historyApiClient.getHistory(4, page4);
    list5 = await _historyApiClient.getHistory(5, page5);
    loadChart1();
    loadChart2();
    loadChart3();
    loadChart4();
    loadChart5();
    view.updateState();
  }

  void initController(ScrollController controller, Function onLoad) {
    controller.addListener(() {
      final maxScroll = controller.position.maxScrollExtent;
      if (controller.offset >= maxScroll && !controller.position.outOfRange) {
        onLoad();
      }
    });
  }

  void myLoadMore1() async {
    if (isMore1) {
      page1 += 1;
      List obs = await _historyApiClient.getHistory(1, page1);
      if (obs.isEmpty) isMore1 = false;
      if (obs.isNotEmpty) {
        list1.addAll(obs);
        view.updateState();
      }
    } else {
      debugPrint('No More Data');
    }
  }

  void myLoadMore2() async {
    if (isMore2) {
      page2 += 1;
      List obs = await _historyApiClient.getHistory(2, page2);
      if (obs.isEmpty) isMore2 = false;
      if (obs.isNotEmpty) {
        list2.addAll(obs);
        view.updateState();
      }
    } else {
      debugPrint('No More Data');
    }
  }

  void myLoadMore3() async {
    if (isMore3) {
      page3 += 1;
      List obs = await _historyApiClient.getHistory(3, page3);
      if (obs.isEmpty) isMore3 = false;
      if (obs.isNotEmpty) {
        list3.addAll(obs);
        view.updateState();
      }
    } else {
      debugPrint('No More Data');
    }
  }

  void myLoadMore4() async {
    if (isMore4) {
      page4 += 1;
      List obs = await _historyApiClient.getHistory(4, page4);
      if (obs.isEmpty) isMore4 = false;
      if (obs.isNotEmpty) {
        list4.addAll(obs);
        view.updateState();
      }
    } else {
      debugPrint('No More Data');
    }
  }

  void myLoadMore5() async {
    if (isMore5) {
      page5 += 1;
      List obs = await _historyApiClient.getHistory(5, page5);
      if (obs.isEmpty) isMore5 = false;
      if (obs.isNotEmpty) {
        list5.addAll(obs);
        view.updateState();
      }
    } else {
      debugPrint('No More Data');
    }
  }

  Widget itemBuilder1(BuildContext context, int index) {
    if (isFirst && list1.isEmpty) {
      return loadingView();
    } else {
      if (list1.isEmpty) {
        return noDataView(isListView: false, title: 'Không có dữ liệu!');
      } else {
        if (index < list1.length) {
          HistoryModel model = list1[index];
          List<String> data = model.date.split(' ');
          DateTime dateTime = DateTime.parse(data[0]);
          String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          String time = data[1].substring(0, 5);
          return ItemHistoryView(
              model: model, time: time, date: date, onExamHis: onExamHis);
        }
        return const SizedBox.shrink();
      }
    }
  }

  Widget itemBuilder2(BuildContext context, int index) {
    if (isFirst && list2.isEmpty) {
      return loadingView();
    } else {
      if (list2.isEmpty) {
        return noDataView(isListView: false, title: 'Không có dữ liệu!');
      } else {
        if (index < list2.length) {
          HistoryModel model = list2[index];
          List<String> data = model.date.split(' ');
          DateTime dateTime = DateTime.parse(data[0]);
          String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          String time = data[1].substring(0, 5);
          return ItemHistoryView(
              model: model, time: time, date: date, onExamHis: onExamHis);
        }
        return const SizedBox.shrink();
      }
    }
  }

  Widget itemBuilder3(BuildContext context, int index) {
    if (isFirst && list3.isEmpty) {
      return loadingView();
    } else {
      if (list3.isEmpty) {
        return noDataView(isListView: false, title: 'Không có dữ liệu!');
      } else {
        if (index < list3.length) {
          HistoryModel model = list3[index];
          List<String> data = model.date.split(' ');
          DateTime dateTime = DateTime.parse(data[0]);
          String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          String time = data[1].substring(0, 5);
          return ItemHistoryView(
              model: model, time: time, date: date, onExamHis: onExamHis);
        }
        return const SizedBox.shrink();
      }
    }
  }

  Widget itemBuilder4(BuildContext context, int index) {
    if (isFirst && list4.isEmpty) {
      return loadingView();
    } else {
      if (list4.isEmpty) {
        return noDataView(isListView: false, title: 'Không có dữ liệu!');
      } else {
        if (index < list4.length) {
          HistoryModel model = list4[index];
          List<String> data = model.date.split(' ');
          DateTime dateTime = DateTime.parse(data[0]);
          String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          String time = data[1].substring(0, 5);
          return ItemHistoryView(
              model: model, time: time, date: date, onExamHis: onExamHis);
        }
        return const SizedBox.shrink();
      }
    }
  }

  Widget itemBuilder5(BuildContext context, int index) {
    if (isFirst && list5.isEmpty) {
      return loadingView();
    } else {
      if (list5.isEmpty) {
        return noDataView(isListView: false, title: 'Không có dữ liệu!');
      } else {
        if (index < list5.length) {
          HistoryModel model = list5[index];
          List<String> data = model.date.split(' ');
          DateTime dateTime = DateTime.parse(data[0]);
          String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
          String time = data[1].substring(0, 5);
          return ItemHistoryView(
              model: model, time: time, date: date, onExamHis: onExamHis);
        }
        return const SizedBox.shrink();
      }
    }
  }

  void loadChart1() {
    double numP = 0.2;
    int numExam = 0;
    if (list1.isNotEmpty) {
      if (list1.length < 10) {
        for (int i = list1.length - 1; i >= 0; i--) {
          HistoryModel model = list1[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart1.add(modelChart);
        }
      } else {
        for (int i = 9; i >= 0; i--) {
          HistoryModel model = list1[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart1.add(modelChart);
        }
      }
    }
  }

  void loadChart2() {
    double numP = 0.25;
    int numExam = 0;
    if (list2.isNotEmpty) {
      if (list2.length < 10) {
        for (int i = list2.length - 1; i >= 0; i--) {
          HistoryModel model = list2[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart2.add(modelChart);
        }
      } else {
        for (int i = 9; i >= 0; i--) {
          HistoryModel model = list2[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart2.add(modelChart);
        }
      }
    }
  }

  void loadChart3() {
    double numP = 0.25;
    int numExam = 0;
    if (list3.isNotEmpty) {
      if (list3.length < 10) {
        for (int i = list3.length - 1; i >= 0; i--) {
          HistoryModel model = list3[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart3.add(modelChart);
        }
      } else {
        for (int i = 9; i >= 0; i--) {
          HistoryModel model = list3[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart3.add(modelChart);
        }
      }
    }
  }

  void loadChart4() {
    double numP = 0.25;
    int numExam = 0;
    if (list4.isNotEmpty) {
      if (list4.length < 10) {
        for (int i = list4.length - 1; i >= 0; i--) {
          HistoryModel model = list4[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart4.add(modelChart);
        }
      } else {
        for (int i = 9; i >= 0; i--) {
          HistoryModel model = list4[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart4.add(modelChart);
        }
      }
    }
  }

  void loadChart5() {
    double numP = 0.2;
    int numExam = 0;
    if (list5.isNotEmpty) {
      if (list5.length < 10) {
        for (int i = list5.length - 1; i >= 0; i--) {
          HistoryModel model = list5[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart5.add(modelChart);
        }
      } else {
        for (int i = 9; i >= 0; i--) {
          HistoryModel model = list5[i];
          numExam++;
          HisChart modelChart =
              HisChart(point: (model.trueAnswer * numP), num: numExam);
          listChart5.add(modelChart);
        }
      }
    }
  }

  void onExamHis(
      int idExam, int idSub, int idHis, List<int> listAns, int type) async {
    loadingData(Const.loadingData2);
    userRes.listAnswerExe.clear();
    userRes.listAnswerExe.addAll(listAns);
    bool isSaveExam = false;
    if (idSub == 1) isSaveExam = await _quesHive.checkExamSave(idExam);
    if (isSaveExam) {
      //Exam already save in mobile.
      list = await _quesHive.getExam(idExam);
      await decodeHtml(list);
      onNavigatorExam(idExam, idSub, idHis, type);
    } else {
      //Exam not save in mobile.
      list = await _courseApiClient.getQuestion(idExam);
      await decodeHtml(list);
      if (idSub == 1) await _quesHive.addExam(userRes.listQuesHive, idExam);
      onNavigatorExam(idExam, idSub, idHis, type);
    }
  }

  void onNavigatorExam(int idExam, int idSub, int idHis, int type) {
    if (idSub == 5) {
      onBack();
      Utils.navigatePage(
        context,
        EnglishView(
          listQues: list,
          idExam: idExam,
          isIdExam: type,
          idHis: idHis,
          idSchedule: 0,
        ),
      );
    } else {
      String nameSub = Utils.listSubDoc[idSub - 1];
      String timeSub = Utils.listTimeSub[idSub - 1];
      onBack();
      Utils.navigatePage(
        context,
        PracticeView(
          idExam: idExam,
          listQuestion: list,
          isIdExam: type,
          nameSubject: nameSub,
          timeSub: timeSub,
          idHis: idHis,
          idSchedule: 0,
          idSub: idSub,
        ),
      );
    }
  }
}
