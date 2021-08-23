import 'package:hava/src/lib_view.dart';
import 'video_presenter.dart';

class VideoView extends StatefulWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> implements Contract {
  late VideoPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = VideoPresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthAd = (MediaQuery.of(context).size.width - 105) / 2;
    return Scaffold(
      appBar: AppBar(title: const Text('Video động lực')),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset('assets/images/bg_video.png'),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          VAll.adView(
            img: 'assets/images/img_ad.png',
            txt: buildTxt(),
            onTap: _presenter.onHideView,
            isShow: _presenter.isShow,
            width: widthAd,
            hGui: _presenter.userRes.hGuide,
            wGui: _presenter.userRes.wGuide,
          ),
        ],
      ),
    );
  }

  Widget buildTxt() {
    return Text(
      'Nếu bạn chưa từng cố gắng thì cũng đừng buồn nếu thất bại.',
      style: Styles.txtBlack(
        size: _presenter.userRes.sizeTxt,
        height: _presenter.userRes.heightTxt,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
