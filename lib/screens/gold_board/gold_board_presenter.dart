import 'dart:async';
import 'package:hava/screens/dialog/alert_ok_dialog.dart';
import 'package:hava/screens/ques_hive/ques_hive.dart';
import 'gold_api_client.dart';
import 'item_gold_board_view.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/models/exam_model.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/models/gold_broad_model.dart';
import 'package:hava/pages/home/home_api_client.dart';
import 'package:hava/screens/course/course_api_client.dart';
import 'package:hava/screens/course/english/english_view.dart';
import 'package:hava/screens/course/practice/practice_view.dart';

class GoldBoardPresenter extends Presenter {
  GoldBoardPresenter(BuildContext context, Contract view)
      : super(context, view);

  List test = [1, 2, 3, 4, 5];
  bool isCancelTime = false;
  late GoldApiClient _apiClient;
  late CourseApiClient _courseApiClient;
  late HomeApiClient _homeApiClient;
  late ExamScheduleModel modelSchedule;
  late QuesHive _quesHive;

  //Calculator Time.
  Timer? myTimer;
  int day = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;
  String titleSub = 'Môn Toán Học bắt đầu sau';

  //Show Time.
  String dayShow = '0';
  String hourShow = '0';
  String minuteShow = '0';
  String secondShow = '0';
  late DateTime dateBegin, dateEnd, date15, dateNow;
  List listModel = [];

  //Time Exam.
  int secondEx = 0;
  int minuteEx = 0;
  int idSubExam = 0;
  bool isStart = false;
  String timeExam = '';
  String dayExam = '';

  //String Exam;
  String examTitle = 'SẮP BẮT ĐẦU';

  @override
  void init() {
    super.init();
    _apiClient = GoldApiClient(context);
    _courseApiClient = CourseApiClient(context);
    _homeApiClient = HomeApiClient(context);
   // userRes.listAnswerResult = [];
    _quesHive = QuesHive();
  }

  @override
  void loadData() {
    super.loadData();
    getScheduleGold();
  }

  void getScheduleGold() async {
    showLoading();
    list = test;
    dateNow = DateTime.now();
    final result = await _homeApiClient.getSchedule();
    if (result != '') {
      modelSchedule = ExamScheduleModel.fromJson(result);
      dateBegin = DateTime.parse(modelSchedule.begin);
      dateEnd = DateTime.parse(modelSchedule.end);
      date15 = dateBegin.add(const Duration(minutes: 15));
      idSubExam = modelSchedule.categoryId;
      timeExam = modelSchedule.begin.substring(11, 16);
      String dayRaw = modelSchedule.begin.substring(8, 10) +
          '-' +
          modelSchedule.begin.substring(5, 7) +
          '-' +
          modelSchedule.begin.substring(0, 4);
      dayExam = '${Utils.dayOfWeek[dateBegin.weekday - 1]}, ngày $dayRaw';

      //dateNow < dateBegin => Đếm ngược đến thời gian bắt đầu thi.
      if (dateNow.compareTo(dateBegin) == -1) {
        titleSub = 'Môn ${modelSchedule.subjectName} bắt đầu sau';
        calTimeExam();
        countDownTime();
      }
      // dateNow == dateBegin => đếm ngược thời gian kết thúc bài thi.
      if (dateNow.compareTo(dateBegin) == 0) {
        examTitle = 'ĐANG DIỄN RA';
        timeExam = modelSchedule.begin.substring(11, 16) +
            ' - ' +
            modelSchedule.end.substring(11, 16);
        isStart = true;
        calOnExam();
        cDOnExam();
      }
      //dateNow > dateBegin && dateNow < dateEnd => đếm ngược thời gian kết thúc bài thi.
      if (dateNow.compareTo(dateBegin) == 1 &&
          dateNow.compareTo(dateEnd) == -1) {
        examTitle = 'ĐANG DIỄN RA';
        timeExam = modelSchedule.begin.substring(11, 16) +
            ' - ' +
            modelSchedule.end.substring(11, 16);
        isStart = true;
        calOnExam();
        cDOnExam();
      }
    } else {
      isCancelTime = true;
      idSubExam = 0;
      titleSub = 'Coming soon';
    }
    for (int i = 1; i <= 5; i++) {
      List<GoldBroadModel> listRaw = await _apiClient.getGoldBroad(i);
      listModel.add(listRaw);
    }
    await hideLoading();
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      int numList = 0;
      String img = 'assets/images/bv_sub${index + 1}.png';
      String name = Utils.listSubDoc[index];
      List<GoldBroadModel> gList = listModel[index];
      GoldBroadModel gModel = gList[gList.length - 1];
      if (gModel.stt == 0) numList = 1;
      return ItemGoldBoardView(
        img: img,
        name: name,
        index: index + 1,
        listModel: gList,
        idSubExam: idSubExam,
        timeExam: timeExam,
        dayExam: dayExam,
        onStart: onStart,
        examTitle: examTitle,
        listAll: listModel,
        seenResult: seenResult,
        numList: numList,
      );
    }
    return super.itemBuild(context, index);
  }

  void calTimeExam() {
    DateTime dateExam = DateTime.parse(modelSchedule.begin);
    day = dateExam.difference(dateNow).inDays;
    hour = (dateExam.difference(dateNow).inHours) % 24;
    minute = (dateExam.difference(dateNow).inMinutes) % 60;
    second = (dateExam.difference(dateNow).inSeconds) % 60;
    if (second < 60) second += 2;
    if (second < 10) secondShow = '0$second';
    if (second >= 10) secondShow = '$second';
    if (minute < 10) minuteShow = '0$minute';
    if (minute >= 10) minuteShow = '$minute';
    if (hour < 10) hourShow = '0$hour';
    if (hour >= 10) hourShow = '$hour';
    if (day < 10) dayShow = '0$day';
    if (day >= 10) dayShow = '$day';
  }

  void calOnExam() {
    titleSub = 'Môn ${modelSchedule.subjectName} kết thúc sau';
    minuteEx = (dateEnd.difference(dateNow).inMinutes);
    secondEx = (dateEnd.difference(dateNow).inSeconds) % 60;
    //if(secondEx <60) secondEx+=2;
    if (minuteEx < 10) minuteShow = '0$minuteEx';
    if (minuteEx >= 10) minuteShow = '$minuteEx';
    if (secondEx < 10) secondShow = '0$secondEx';
    if (secondEx >= 10) secondShow = '$secondEx';
  }

  void countDownTime() {
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (day == 0 && hour == 0 && minute == 0 && second == 0) {
        timer.cancel();
        print('bắt đầu thi');
        isStart = true;
        dateNow = DateTime.now();
        calOnExam();
        cDOnExam();
        examTitle = 'ĐANG DIỄN RA';
        timeExam = modelSchedule.begin.substring(11, 16) +
            ' - ' +
            modelSchedule.end.substring(11, 16);
        view.updateState();
      } else {
        if (second == 0) {
          if (minute == 0) {
            if (hour == 0) {
              day--;
              hour = 24;
              if (day < 10) dayShow = '0$day';
              if (day >= 10) dayShow = '$day';
            }
            hour--;
            minute = 60;
            if (hour < 10) hourShow = '0$hour';
            if (hour >= 10) hourShow = '$hour';
          }
          minute--;
          second = 60;
          if (minute < 10) minuteShow = '0$minute';
          if (minute >= 10) minuteShow = '$minute';
        }
        second--;
        if (second < 10) secondShow = '0$second';
        if (second >= 10) secondShow = '$second';
        BlocProvider.of<AuthBloc>(context).add(CDDetailScheduleEvent());
      }
    });
  }

  void cDOnExam() {
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minuteEx == 0 && secondEx == 0) {
        timer.cancel();
        print('ket thuc!');
        getScheduleGold();
      } else {
        if (secondEx == 0) {
          minuteEx--;
          secondEx = 60;
          if (minuteEx < 10) minuteShow = '0$minuteEx';
          if (minuteEx >= 10) minuteShow = '$minuteEx';
        }
        secondEx--;
        if (secondEx < 10) secondShow = '0$secondEx';
        if (secondEx >= 10) secondShow = '$secondEx';
        BlocProvider.of<AuthBloc>(context).add(CDDetailScheduleEvent());
      }
    });
  }

  void onStart() async {
    DateTime dateNow15 = DateTime.now();
    if (isStart) {
      if (dateNow15.compareTo(date15) == -1) {
        final result = await _apiClient.checkExam(modelSchedule.id);
        if (result == false) {
          onPractice(modelSchedule.examId, modelSchedule.categoryId, 0,
              modelSchedule.id);
        } else {
          showDialogExam('Thông báo!', 'Em đã thi bài thi này rồi!');
        }
      } else {
        showDialogExam('Thông báo!', 'Đã quá thời gian dự thi!');
      }
    } else {
      showDialogExam('Thông báo!', 'Bài thi chưa bắt đầu!');
    }
  }

  void seenResult(int idSub, int idExam) {
    onPractice(idExam, idSub, -1, 0);
  }

  void onPractice(int id, int idSub, int idHis, int idSchedule) async {
    loadingData(Const.loadingData1);
    bool isSaveExam = false;
    if (idSub == 1) isSaveExam = await _quesHive.checkExamSave(id);
    if (isSaveExam) {
      //Exam already save in mobile.
      list = await _quesHive.getExam(id);
      await decodeHtml(list);
      onNavigatorExam(id, idSub, idHis, idSchedule);
    } else {
      //Exam not save in mobile.
      list = await _courseApiClient.getQuestion(id);
      await decodeHtml(list);
      if (idSub == 1) await _quesHive.addExam(userRes.listQuesHive, id);
      onNavigatorExam(id, idSub, idHis, idSchedule);
    }
  }

  void onNavigatorExam(int id, int idSub, int idHis, int idSchedule) {
    if (idSub == 5) {
      onBack();
      Utils.navigatePage(
        context,
        EnglishView(
          listQues: list,
          idExam: id,
          isIdExam: 2,
          idHis: idHis,
          idSchedule: idSchedule,
        ),
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
          isIdExam: 2,
          nameSubject: nameSub,
          timeSub: timeSub,
          idHis: idHis,
          idSchedule: idSchedule,
          idSub: idSub,
        ),
      );
    }
  }

  void showDialogExam(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertOkDialog(
        title: title,
        content: content,
        ok: onBack,
      ),
    );
  }
}
