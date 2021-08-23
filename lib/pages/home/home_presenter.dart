import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/models/exam_model.dart';
import 'package:hava/screens/info_user/info_user_view.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hava/models/feedback_model.dart';
import 'package:hava/screens/average/average_view.dart';
import 'package:hava/screens/course/course_view.dart';
import 'package:hava/screens/gold_board/gold_board_view.dart';
import 'package:hava/screens/guide/guide_view.dart';
import 'package:hava/screens/remind/remind_view.dart';
import 'package:hava/screens/search/search_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_api_client.dart';
import 'item_home_view.dart';

class HomePresenter extends Presenter {
  HomePresenter(BuildContext context, Contract view) : super(context, view);
  int indexCurrent = 0;
  bool isShow = true;
  late HomeApiClient _homeApiClient;
  late ExamScheduleModel modelSchedule;

  //Calculator Time.
  Timer? timer;
  int day = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;
  String titleSub = 'Môn Toán Học bắt đầu sau';
  bool isCancelTime = false;

  //Show Time.
  String dayShow = '0';
  String hourShow = '0';
  String minuteShow = '0';
  String secondShow = '0';
  late DateTime dateNow;
  late DateTime dateBegin, dateEnd;
  bool isReload = false;

  //Time Exam.
  int secondEx = 0;
  int minuteEx = 0;

  @override
  void init() {
    super.init();
    _homeApiClient = HomeApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    if(isReload) timer!.cancel();
    list = await _homeApiClient.getFeedBack();
    getScheduleGold();
  }

  Future getScheduleGold() async {
    dateNow = DateTime.now();
    final result = await _homeApiClient.getSchedule();

    print('$result -- $dateNow');
    if (result != '') {
      modelSchedule = ExamScheduleModel.fromJson(result);
      dateBegin = DateTime.parse(modelSchedule.begin);
      dateEnd = DateTime.parse(modelSchedule.end);
      // dateNow < dateBegin => Đếm ngược đến thời gian bắt đầu thi.
      if (dateNow.compareTo(dateBegin) == -1) {
        titleSub = 'Môn ${modelSchedule.subjectName} bắt đầu sau';
        calTimeExam();
        countDownTime();
      }
      // dateNow == dateBegin => đếm ngược thời gian kết thúc bài thi.
      if (dateNow.compareTo(dateBegin) == 0) {
        calOnExam();
        cDOnExam();
      }
      //dateNow > dateBegin && dateNow < dateEnd => đếm ngược thời gian kết thúc bài thi.
      if (dateNow.compareTo(dateBegin) == 1 &&
          dateNow.compareTo(dateEnd) == -1) {
        calOnExam();
        cDOnExam();
      }
    } else {
      isCancelTime = true;
      titleSub = 'Coming soon';
    }
    view.updateState();
  }

  void calTimeExam() {
    DateTime dateExam = DateTime.parse(modelSchedule.begin);
    day = dateExam.difference(dateNow).inDays;
    hour = (dateExam.difference(dateNow).inHours) % 24;
    minute = (dateExam.difference(dateNow).inMinutes) % 60;
    second = (dateExam.difference(dateNow).inSeconds) % 60;
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
    if (minuteEx < 10) minuteShow = '0$minuteEx';
    if (minuteEx >= 10) minuteShow = '$minuteEx';
    if (secondEx < 10) secondShow = '0$secondEx';
    if (secondEx >= 10) secondShow = '$secondEx';
  }

  void countDownTime() {
    isReload = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (day == 0 && hour == 0 && minute == 0 && second == 0) {
        timer.cancel();
        print('bắt đầu thi');
        dateNow = DateTime.now();
        calOnExam();
        cDOnExam();
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
        BlocProvider.of<AuthBloc>(context).add(CDExamScheduleEvent());
      }
    });
  }

  void cDOnExam() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
        BlocProvider.of<AuthBloc>(context).add(CDExamScheduleEvent());
      }
    });
  }

  void onSearch() {
    Utils.navigatePage(context, const SearchView());
  }

  void onSubject(int type) {
    String sub = '';
    String img = '';
    int id = 0;
    switch (type) {
      case 0:
        sub = 'Toán học';
        img = 'assets/icons/ic_sub1.png';
        id = 1;
        break;
      case 1:
        sub = 'Vật lý';
        img = 'assets/icons/ic_sub22.png';
        id = 2;
        break;
      case 2:
        sub = 'Hóa học';
        img = 'assets/icons/ic_sub3.png';
        id = 3;
        break;
      case 3:
        sub = 'Sinh học';
        img = 'assets/icons/ic_sub9.png';
        id = 4;
        break;
      case 4:
        sub = 'Tiếng anh';
        img = 'assets/icons/ic_sub8.png';
        id = 5;
        break;
      case 5:
        sub = 'Ngữ văn';
        img = 'assets/icons/ic_sub6.png';
        id = 9;
        break;
      case 6:
        sub = 'Địa lý';
        img = 'assets/icons/ic_sub5.png';
        id = 7;
        break;
      case 7:
        sub = 'GDCD';
        img = 'assets/icons/ic_sub7.png';
        id = 8;
        break;
      case 8:
        sub = 'Lịch Sử';
        img = 'assets/icons/ic_sub4.png';
        id = 6;
        break;
    }
    Utils.navigatePage(context, CourseView(sub: sub, img: img, id: id));
  }

  void onMore(int type) {
    switch (type) {
      case 1:
        Utils.navigatePage(context, const AverageView());
        break;
      case 2:
        Utils.navigatePage(context, const RemindView());
        break;
    }
  }

  void onChangeIndex(int index, CarouselPageChangedReason reason) {
    indexCurrent = index;
    view.updateState();
  }

  Widget buildCarousel(BuildContext context, int index, int realIndex) {
    if (index < list.length) {
      FeedBackModel model = list[index];
      return ItemHomeView(model: model);
    }
    return Container();
  }

  void onHideView() {
    isShow = false;
    view.updateState();
  }

  void onGuide() async {
    await launch('https://www.messenger.com/t/tuhocdocao');
  }

  void onGoldBoard() {
    Utils.navigatePage(context, const GoldBoardView());
  }

  void onUser() {
    Utils.navigatePage(context, const InfoUserView(isFirstLg: false));
  }
}
