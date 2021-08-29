import 'package:hava/src/lib_exe.dart';
import 'package:hava/src/lib_presenter.dart';
import 'item_pra_view.dart';
import 'pra_result_view.dart';

class PracticePresenter extends Presenter {
  PracticePresenter(
      BuildContext context,
      Contract view,
      this.idExam,
      this.listQues,
      this.isIdExam,
      this.timeSub,
      this.nameSub,
      this.idHis,
      this.idSchedule,
      this.idSub)
      : super(context, view);

  // Data final.
  final List listQues;
  final int idExam, isIdExam, idHis, idSchedule, idSub;
  final String timeSub, nameSub;
  late CourseApiClient _apiClient;
  TabController? tabController;
  int indexTab = 0;
  late ConfettiController controllerCenter;
  late ScreenshotController screenshotController;

  //CountDownTimer
  Timer? timer;
  int minute = 0;
  int second = 60;
  String minuteShow = '00';
  String secondShow = '00';

  //Data.
  String titleAppbar = 'Luyện đề';
  bool showLight = true;
  bool isSubmit = false;
  bool isDialog = false;
  int numRightAns = 0;
  double point = 0;
  String whenSubmit = 'NỘP BÀI';
  String notifyResult = '';
  List<TotalHisModel> listTotalHis = [];
  String timeSubmit = '';
  String pointShow = '0';
  DateTime dateNow = DateTime.now();
  AudioPlayer audioPlayer = AudioPlayer();
  late AudioCache audioCache;

  @override
  void init() {
    super.init();
    _apiClient = CourseApiClient(context);
    controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    screenshotController = ScreenshotController();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  void loadData() async {
    super.loadData();
    if (isIdExam == 1) titleAppbar = 'Luyện thi';
    if (isIdExam == 2) titleAppbar = 'Đấu trường thi';
    if (isIdExam == 3) titleAppbar = 'Bài tập';
    if (idHis == 0) {
      onResetAn();
      userRes.qsChoice = 0;
      minuteShow = timeSub;
      minute = int.parse(timeSub);
      if (isIdExam != 3) countDownTime();
      if (isIdExam == 1) showLight = false;
      if (isIdExam == 2) showLight = false;
    } else if (idHis == -1) {
      onResetAn();
      minuteShow = timeSub;
      isSubmit = true;
    } else {
      minuteShow = timeSub;
      userRes.qsChoice = 0;
      historyView();
    }

    view.updateState();
  }

  void onResetAn() {
    userRes.listAnswerExe = [];
    for (int i = 0; i < userRes.listAnswerResult.length; i++) {
      userRes.listAnswerExe.add(0);
    }
  }

  void countDownTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minute == 0 && second == 0) {
        acceptSubmit();
      } else {
        if (minute == int.parse(timeSub)) {
          minute--;
          minuteShow = '$minute';
        }
        if (second == 0) {
          minute--;
          second = 60;
          if (minute < 10) minuteShow = '0$minute';
          if (minute >= 10) minuteShow = '$minute';
        }
        second--;
        if (second < 10) secondShow = '0$second';
        if (second >= 10) secondShow = '$second';
        BlocProvider.of<AuthBloc>(context).add(CountDownTimeEvent());
      }
    });
  }

  void dialogShowResult() {
    showDialog(
      context: context,
      builder: (_) {
        return ResultDialog(
          onBack: onBack,
          point: pointShow,
          numQs: numRightAns,
          notifyResult: notifyResult,
          onReView: totalResult,
          onShare: onShare,
          numAllQues: listQues.length,
          time: timeSubmit,
          controller: controllerCenter,
          screenshotController: screenshotController,
          nameSub: nameSub,
        );
      },
    );
  }

  void dialogShowNotify(String name, Function() onTap) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
            title: 'Lời nhắc', content: name, cancel: onBack, ok: onTap);
      },
    );
  }

  void showTxtResult() {
    if (point < 5) {
      notifyResult = Utils.notify3;
    } else if (point >= 5 && point < 8) {
      notifyResult = Utils.notify4;
    } else if (point >= 8 && point <= 9) {
      notifyResult = Utils.notify5;
    } else {
      notifyResult = Utils.notify6;
    }
  }

  void showMusic() {
    if (point >= 7) {
      audioCache.play('music/true.mp3');
      controllerCenter.play();
    } else {
      audioCache.play('music/false.mp3');
    }
  }

  void historyView() async {
    loadingData(Const.loadingData2);
    isSubmit = true;
    whenSubmit = 'Xem Kết Quả';
    int indexModel = 0;
    double pointRaw = 10 / userRes.numQuesEng;

    for (int i = 0; i < listQues.length; i++) {
      QuestionModel model = listQues[i];
      if (model.answerTrue != 0) {
        if (userRes.listAnswerExe[indexModel] ==
            userRes.listAnswerResult[indexModel]) {
          point += pointRaw;
          numRightAns += 1;
        }
        if (userRes.listAnswerExe[indexModel] != 0) {
          userRes.qsChoice++;
        }
        indexModel++;
      }
    }
    showTxtResult();
    timeSubmit = '$minuteShow:$secondShow';
    pointShow = '$point';
    if (point != 0 && isIdExam == 3) pointShow = point.toStringAsFixed(1);
    listTotalHis = await _apiClient.getTotal(idHis);
    onBack();
    dialogShowResult();
    showMusic();
  }

  void acceptSubmit() async {
    if (isDialog) onBack();
    loadingData(Const.loadingData3);
    if (idHis == 0 && isIdExam != 3) timer!.cancel();
    isSubmit = true;
    List<AnswerModel> listAn = [];
    whenSubmit = 'Xem Kết Quả';
    double pointRaw = 10 / userRes.numQuesEng;

    for (int i = 0; i < listQues.length; i++) {
      QuestionModel model = listQues[i];
      if (model.answerTrue != 0) {
        if (userRes.listAnswerExe[i] == userRes.listAnswerResult[i]) {
          point += pointRaw;
          numRightAns += 1;
        }
        AnswerModel modelAns = AnswerModel(
            answer: userRes.listAnswerExe[i], id_question: model.id);
        listAn.add(modelAns);
      }
    }

    showTxtResult();
    pointShow = '$point';
    if (point != 0 && isIdExam == 3) pointShow = point.toStringAsFixed(1);
    if (isIdExam == 3) {
      DateTime dateNew = DateTime.now();
      int minute = (dateNew.difference(dateNow).inMinutes);
      int second = (dateNew.difference(dateNow).inSeconds) % 60;
      String minuteShow = '$minute';
      String secondShow = '$second';
      if (minute < 10) minuteShow = '0$minute';
      if (second < 10) secondShow = '0$second';
      timeSubmit = '$minuteShow:$secondShow';
    } else {
      totalTime();
    }

    if (isIdExam == 3) {
      ListExeModel exeModel = ListExeModel(idExam: idExam, answerModel: listAn);
      var jsonModel = await _apiClient.addExe(jsonEncode(exeModel));
      listTotalHis = TotalHisModelList.fromJson(jsonModel).list;
    } else {
      ListAnswerModel listAnswerModel = ListAnswerModel(
        id_exam: idExam,
        answerModel: listAn,
        test_schedules_id: idSchedule,
        type: isIdExam,
      );
      int idHis = await _apiClient.addHistory(jsonEncode(listAnswerModel));
      listTotalHis = await _apiClient.getTotal(idHis);
    }
    onBack();
    if(isIdExam == 2){
      onBack();
    }else{
      dialogShowResult();
      showMusic();
      view.updateState();
    }
  }

  void onSubmit() {
    onBack();
    if (!isSubmit) {
      isDialog = true;
      if (userRes.qsChoice < 50) {
        if (!isSubmit) dialogShowNotify(Utils.notify1, acceptSubmit);
      } else {
        if (!isSubmit) dialogShowNotify(Utils.notify2, acceptSubmit);
      }
    } else {
      dialogShowResult();
    }
  }

  void onTapQuestion(int index) {
    indexTab = index;
    tabController!.index = index;
    BlocProvider.of<AuthBloc>(context).add(ClickTabBarEvent());
  }

  void onBackTab() {
    if (indexTab > 0) {
      indexTab -= 1;
      tabController!.index = indexTab;
      BlocProvider.of<AuthBloc>(context).add(ClickTabBarEvent());
    }
  }

  void onNextTab() {
    if (indexTab < listQues.length - 1) {
      indexTab += 1;
      tabController!.index = indexTab;
      BlocProvider.of<AuthBloc>(context).add(ClickTabBarEvent());
    }
  }

  List<Widget> buildListTab() {
    List<ItemPraView> question =
        List<ItemPraView>.generate(listQues.length, (index) {
      QuestionModel model = listQues[index];
      return ItemPraView(
          model: model, index: index, showLight: showLight, idSub: idSub);
    });
    return question;
  }

  List<Widget> listTab2() {
    List<PraResultView> question =
        List<PraResultView>.generate(listQues.length, (index) {
      QuestionModel model = listQues[index];
      return PraResultView(model: model, index: index, idSub: idSub);
    });
    return question;
  }

  void on2Back() {
    onBack();
    onBack();
  }

  void onBackExam() {
    if (isSubmit) onBack();
    if (!isSubmit) dialogShowNotify(Utils.notify7, on2Back);
  }

  void totalResult() {
    onBack();
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      context: context,
      builder: (context) => TotalHisDialog(
        onBack: onBack,
        listTotal: listTotalHis,
        txtSize: userRes.fSize,
      ),
    );
  }

  void totalTime() {
    int minuteSub = int.parse(timeSub) - minute - 1;
    if (minute == 0) minuteSub = int.parse(timeSub);
    int secondSub = 60 - second;
    String minuteShow = '$minuteSub';
    String secondShow = '$secondSub';
    if (minuteSub < 10) minuteShow = '0$minuteSub';
    if (secondSub < 10) secondShow = '0$secondSub';
    timeSubmit = '$minuteShow:$secondShow';
  }

  void onShare() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);
        await Share.shareFiles([imagePath.path]);
      }
    });
  }

  Future<bool> onWillPopBack() async {
    if (!isSubmit) {
      return (await showDialog(
        context: context,
        builder: (_) {
          return AlertResultDialog(
            title: 'Lời nhắc',
            content: Utils.notify7,
            cancel: onBack,
            ok: on2Back,
          );
        },
      ));
    }
    return true;
  }
}
