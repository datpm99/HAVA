import 'package:hava/src/lib_exe.dart';
import 'package:hava/src/lib_presenter.dart';
import 'eng_result_view.dart';
import 'item_eng_view.dart';

class EnglishPresenter extends Presenter {
  EnglishPresenter(BuildContext context, Contract view, this.listQues,
      this.idExam, this.isIdExam, this.idHis, this.idSchedule)
      : super(context, view);

  // Data final.
  final List listQues;
  final int idExam, isIdExam, idHis, idSchedule;
  late CourseApiClient _apiClient;
  late ConfettiController controllerCenter;
  late ScreenshotController screenshotController;
  late ItemScrollController itemScrollController;

  //CountDownTimer
  Timer? timer;
  int minute = 60;
  int second = 60;
  String minuteShow = '60';
  String secondShow = '00';
  String numQues = '50';

  //Data.
  String titleAppbar = 'Luyện đề';
  bool showLight = true;
  bool isSubmit = false;
  int numRightAns = 0;
  double point = 0;
  String whenSubmit = 'NỘP BÀI';
  String notifyResult = '';
  List<TotalHisModel> listTotalHis = [];
  String timeSubmit = '';
  String pointShow = '0';
  bool isTime = false;
  int indexR = -1;
  DateTime dateNow = DateTime.now();
  AudioPlayer audioPlayer = AudioPlayer();
  late AudioCache audioCache;

  @override
  void init() {
    super.init();
    _apiClient = CourseApiClient(context);
    itemScrollController = ItemScrollController();
    screenshotController = ScreenshotController();
    controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  void loadData() {
    super.loadData();
    if (isIdExam == 1) titleAppbar = 'Luyện thi';
    if (isIdExam == 2) titleAppbar = 'Đấu trường thi';
    if (isIdExam == 3) titleAppbar = 'Bài tập';
    list = listQues;
    if (idHis == 0) {
      //Do exam.
      onResetAn();
      userRes.qsChoice = 0;
      if (isIdExam != 3) countDownTime();
      if (isIdExam == 1) showLight = false;
      if (isIdExam == 3) numQues = '${listQues.length - 1}';
    } else if (idHis == -1) {
      //View GoldBroad Exam.
      onResetAn();
      isSubmit = true;
    } else {
      //View History Exam.
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

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      QuestionModel model = list[index];
      if (model.answerTrue != 0) indexR++;
      int indexRaw = indexR;
      if (model.answerTrue == 0) indexRaw = -1;
      if (!isSubmit) {
        return ItemEngView(model: model, index: indexRaw, showLight: showLight);
      } else {
        return EngResultView(
            model: model, index: indexRaw, indexList: indexRaw);
      }
    }
    return super.itemBuild(context, index);
  }

  void countDownTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minute == 0 && second == 0) {
        isTime = true;
        acceptSubmit();
      } else {
        if (minute == 60) {
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
        BlocProvider.of<AuthBloc>(context).add(CDTimeEngEvent());
      }
    });
  }

  void dialogShowNotify(String name, Function() onTap) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
          title: 'Lời nhắc',
          content: name,
          cancel: onBack,
          ok: onTap,
        );
      },
    );
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
          numAllQues: userRes.numQuesEng,
          time: timeSubmit,
          controller: controllerCenter,
          screenshotController: screenshotController,
          nameSub: 'Tiếng anh',
        );
      },
    );
  }

  void showTextResult() {
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

  void playMusic() {
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

    for (int i = 0; i < listQues.length; i++) {
      QuestionModel model = listQues[i];
      if (model.answerTrue != 0) {
        if (userRes.listAnswerExe[indexModel] ==
            userRes.listAnswerResult[indexModel]) {
          point += 0.2;
          numRightAns += 1;
        }
        if (userRes.listAnswerExe[indexModel] != 0) {
          userRes.qsChoice++;
        }
        indexModel++;
      }
    }

    showTextResult();

    timeSubmit = '$minuteShow:$secondShow';
    if (point != 0) pointShow = point.toStringAsFixed(1);
    listTotalHis = await _apiClient.getTotal(idHis);
    onBack();
    dialogShowResult();
    playMusic();
  }

  void acceptSubmit() async {
    if (!isTime) onBack();
    loadingData(Const.loadingData3);
    if (idHis == 0 && isIdExam != 3) timer!.cancel();
    isSubmit = true;
    indexR = -1;
    List<AnswerModel> listAn = [];
    int indexModel = 0;
    whenSubmit = 'Xem Kết Quả';
    double pointRaw = 10 / userRes.numQuesEng;

    for (int i = 0; i < listQues.length; i++) {
      QuestionModel model = listQues[i];
      if (model.answerTrue != 0) {
        if (userRes.listAnswerExe[indexModel] ==
            userRes.listAnswerResult[indexModel]) {
          point += pointRaw;
          numRightAns += 1;
        }
        AnswerModel model1 = AnswerModel(
            answer: userRes.listAnswerExe[indexModel], id_question: model.id);
        listAn.add(model1);
        indexModel++;
      }
    }

    showTextResult();

    if (point != 0) pointShow = point.toStringAsFixed(1);
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
    dialogShowResult();
    playMusic();
    view.updateState();
  }

  void totalTime() {
    int minuteSub = 60 - minute - 1;
    if (minute == 0) minuteSub = 60;
    int secondSub = 60 - second;
    String minuteShow = '$minuteSub';
    String secondShow = '$secondSub';
    if (minuteSub < 10) minuteShow = '0$minuteSub';
    if (secondSub < 10) secondShow = '0$secondSub';
    timeSubmit = '$minuteShow:$secondShow';
  }

  void onSubmit() {
    onBack();
    if (!isSubmit) {
      if (userRes.qsChoice < 50) {
        if (!isSubmit) dialogShowNotify(Utils.notify1, acceptSubmit);
      } else {
        if (!isSubmit) dialogShowNotify(Utils.notify2, acceptSubmit);
      }
    } else {
      dialogShowResult();
    }
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

  void on2Back() {
    onBack();
    onBack();
  }

  void onBackExam() async {
    if (isSubmit) onBack();
    if (!isSubmit) dialogShowNotify(Utils.notify7, on2Back);
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

  void onIndexItem(int index) {
    // int indexRaw = index;
    // for (int i = 0; i < userRes.listQuesNullEng.length - 1; i++) {
    //   if (index >= userRes.listQuesNullEng[i] - i &&
    //       index < userRes.listQuesNullEng[i + 1] - i - 1) {
    //     indexRaw += i + 1;
    //     break;
    //   }
    // }
    // itemScrollController.jumpTo(index: indexRaw);
  }
}
