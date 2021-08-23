import 'package:audioplayers/audioplayers.dart';
import 'package:hava/src/lib_presenter.dart';

class MainPresenter extends Presenter {
  MainPresenter(BuildContext context, Contract view) : super(context, view);
  int bottomSelectedIndex = 0;
  String img = 'assets/icons/ic_play.png';
  bool isPlay = false;
  AudioPlayer audioPlayer = AudioPlayer();
  String url = Utils.listUrlMusic[0];
  int indexUrl = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void init() {
    super.init();
    //audioPlayer.play(url);
    audioPlayer.onPlayerCompletion.listen((event) {
      indexUrl += 1;
      url = Utils.listUrlMusic[indexUrl];
      audioPlayer.play(url);
      if (indexUrl == 7) indexUrl = 0;
    });
  }

  void bottomTapped(int value) async {
    if (value == bottomSelectedIndex) {
    } else {
      bottomSelectedIndex = value;
      pageController.jumpToPage(value);
      view.updateState();
    }
  }

  void pageChanged(int value) {}

  void onPlayMusic() {
    if (isPlay) {
      img = 'assets/icons/ic_play.png';
      audioPlayer.pause();
    } else {
      img = 'assets/icons/ic_pause.png';
      audioPlayer.play(url);
    }
    isPlay = !isPlay;
    view.updateState();
  }

  void onPlayResume() {
    if (isPlay) audioPlayer.play(url);
  }

  void onPlayPause() {
    if (isPlay) audioPlayer.pause();
  }

  void reSize(double width, double height) {
    userRes.widthAll = width;
    userRes.heightAll = height;
    if (userRes.heightAll < 600) {
      userRes.marTop = 30;
      userRes.marBottom = 20;
      userRes.heightImg = 75;
      userRes.titleTxt = 24;
      userRes.icSize = 40;
      userRes.wGuide = 70;
      userRes.hGuide = 170;
      userRes.sizeTxt = 8;
      userRes.icImg1 = 50;
      userRes.wImg = 30;
      userRes.paddingS = 12;
      userRes.videoImg = 120;
      userRes.crossAxis = 10;
      userRes.mainAxis = 0;
      userRes.heightTxt = 1.2;
      userRes.gbImg = 180;
      userRes.gbAvatar = 25;
      userRes.bgHImg = 44;
      userRes.fSize = 10;
      userRes.cwImg = 30;
      userRes.chImg = 30;
      userRes.velSub = 5;
      userRes.heightBox = 0;
    }
  }
}
