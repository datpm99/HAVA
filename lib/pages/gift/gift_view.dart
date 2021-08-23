import 'package:hava/src/lib_view.dart';
import 'gift_presenter.dart';

class GiftView extends StatefulWidget {
  @override
  _GiftViewState createState() => _GiftViewState();
}

class _GiftViewState extends State<GiftView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late GiftPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = GiftPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 45) / 2;
    double widthAd = (MediaQuery.of(context).size.width - 105) / 2;
    return Scaffold(
      appBar: AppBar(title: const Text('Quà tặng')),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildContainer(
                  width: width,
                  onTap: _presenter.onVideo,
                  name: 'Video Động Lực',
                  img: 'assets/images/img_gift2.png',
                ),
                _buildContainer(
                  width: width,
                  onTap: _presenter.onEbook,
                  name: 'Quà Tặng Ebook',
                  img: 'assets/images/img_gift3.png',
                ),
              ],
            ),
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

  Widget _buildContainer({Function()? onTap, double width = 0.0, name, img}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: width,
        margin: const EdgeInsets.only(top: 20, left: 15),
        padding: const EdgeInsets.all(10),
        decoration: VAll.decoRd5(Colors.white, 0.5, Styles.colorG3),
        child: Column(
          children: [
            Text(
              name,
              style: Styles.cusText(color: Styles.colorB2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(child: Image.asset(img, fit: BoxFit.contain)),
          ],
        ),
      ),
    );
  }

  Widget buildTxt() {
    return Text(
      'Bất kỳ chuyên gia trong lĩnh vực nào cũng đã từng là kẻ nghiệp dư.',
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

  @override
  bool get wantKeepAlive => true;
}
