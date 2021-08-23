import 'package:hava/src/lib_view.dart';
import 'ebook_presenter.dart';

class EbookView extends StatefulWidget {
  const EbookView({Key? key}) : super(key: key);

  @override
  _EbookViewState createState() => _EbookViewState();
}

class _EbookViewState extends State<EbookView> implements Contract {
  late EbookPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = EbookPresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthAd = (MediaQuery.of(context).size.width - 105) / 2;
    return Scaffold(
      appBar: AppBar(title: const Text('EBook')),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset('assets/images/bg_ebook.png'),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1.2),
                    crossAxisSpacing: _presenter.userRes.crossAxis,
                    mainAxisSpacing: _presenter.userRes.mainAxis,
                  ),
                  itemCount: _presenter.list.length + 1,
                  itemBuilder: _presenter.itemBuilder,
                ),
              )
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
      'Số trang sách bạn lật ngày hôm nay chính là số tiền mà ngày mai bạn đếm.',
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
