import 'play_video_presenter.dart';
import 'package:flutter/services.dart';
import 'package:hava/src/lib_view.dart';
import 'package:hava/models/video_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PlayVideoView extends StatefulWidget {
  final VideoModel model;

  const PlayVideoView({Key? key, required this.model}) : super(key: key);

  @override
  _PlayVideoViewState createState() => _PlayVideoViewState();
}

class _PlayVideoViewState extends State<PlayVideoView> implements Contract {
  late PlayVideoPresenter _presenter;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _presenter = PlayVideoPresenter(context, this, widget.model);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayerController.convertUrlToId(_presenter.linkYT) ?? '',
      params: const YoutubePlayerParams(
        autoPlay: false,
        showFullscreenButton: true,
        showControls: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthAd = (MediaQuery.of(context).size.width - 105) / 2;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video động lực'),
          leading: GestureDetector(
            onTap: onBackS,
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Styles.colorOr3),
                    ),
                    child: YoutubePlayerIFrame(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _presenter.title,
                    style: Styles.cusText(color: Styles.colorB2),
                  ),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    alignment: Alignment.centerLeft,
                    decoration: VAll.decoR5C(Styles.colorMain),
                    child: Text('Video Khác', style: Styles.cusText()),
                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 0.8),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: _presenter.list.length + 1,
                      itemBuilder: _presenter.itemBuilder,
                    ),
                  ),
                ],
              ),
            ),
            VAll.adView(
              img: 'assets/images/img_ad.png',
              txt: _txtGuide(),
              onTap: _presenter.onHideView,
              isShow: _presenter.isShow,
              width: widthAd,
              hGui: _presenter.userRes.hGuide,
              wGui: _presenter.userRes.wGuide,
            ),
          ],
        ),
      ),
      onWillPop: onWillPopBack,
    );
  }

  Widget _txtGuide() {
    return GestureDetector(
      onTap: _presenter.onGuide,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Xin chào, tôi là trợ lý Hava. Nếu có thắc mắc gì nhấn ngay ',
          style: Styles.txtBlack(
            size: _presenter.userRes.sizeTxt,
            height: _presenter.userRes.heightTxt,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'vào đây',
              style: Styles.txtBlack(
                  size: _presenter.userRes.sizeTxt, color: Styles.colorBlue5),
            ),
            const TextSpan(text: ' nhé !'),
          ],
        ),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }

  void onBackS() {
    _controller.pause();
    _presenter.onBack();
  }

  Future<bool> onWillPopBack() async {
    _controller.pause();
    return true;
  }

  @override
  void dispose() {
    _controller.close();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
