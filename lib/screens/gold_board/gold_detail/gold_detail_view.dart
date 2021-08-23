import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:hava/src/lib_view.dart';
import 'gold_detail_presenter.dart';
import 'item_gold_detail_view.dart';

class GoldDetailView extends StatefulWidget {
  final List listAll;
  final int index, numList;

  const GoldDetailView(
      {Key? key,
      required this.listAll,
      required this.index,
      required this.numList})
      : super(key: key);

  @override
  _GoldDetailViewState createState() => _GoldDetailViewState();
}

class _GoldDetailViewState extends State<GoldDetailView>
    with SingleTickerProviderStateMixin
    implements Contract {
  late TabController _tabController;
  late GoldDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = GoldDetailPresenter(context, this);
    _tabController =
        TabController(vsync: this, length: 5, initialIndex: widget.index - 1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Bảng xếp hạng')),
      body: Column(
        children: [
          Container(
            width: width,
            color: Styles.colorG8,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ButtonsTabBar(
              controller: _tabController,
              backgroundColor: Styles.colorOr3,
              unselectedBackgroundColor: Styles.colorG8,
              labelStyle: Styles.copyStyle(color: Colors.white),
              unselectedLabelStyle: Styles.copyStyle(color: Styles.colorB2),
              borderWidth: 0.5,
              borderColor: Styles.colorOr3,
              unselectedBorderColor: Styles.colorG6,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              tabs: const [
                Tab(text: '   TOÁN   '),
                Tab(text: '  VẬT LÝ  '),
                Tab(text: 'HÓA HỌC'),
                Tab(text: 'SINH HỌC'),
                Tab(text: 'TIẾNG ANH'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ItemGoldDetailView(
                  gbImg: _presenter.userRes.gbImg,
                  bgHImg: _presenter.userRes.bgHImg,
                  gbAvatar: _presenter.userRes.gbAvatar,
                  fSize: _presenter.userRes.fSize,
                  listModel: widget.listAll[0],
                  idUser: _presenter.userRes.user!.userId,
                  numList: widget.numList,
                  numRd: _presenter.userRes.rdMath,
                ),
                ItemGoldDetailView(
                  gbImg: _presenter.userRes.gbImg,
                  bgHImg: _presenter.userRes.bgHImg,
                  gbAvatar: _presenter.userRes.gbAvatar,
                  fSize: _presenter.userRes.fSize,
                  listModel: widget.listAll[1],
                  idUser: _presenter.userRes.user!.userId,
                  numList: widget.numList,
                  numRd: _presenter.userRes.rdPhy,
                ),
                ItemGoldDetailView(
                  gbImg: _presenter.userRes.gbImg,
                  bgHImg: _presenter.userRes.bgHImg,
                  gbAvatar: _presenter.userRes.gbAvatar,
                  fSize: _presenter.userRes.fSize,
                  listModel: widget.listAll[2],
                  idUser: _presenter.userRes.user!.userId,
                  numList: widget.numList,
                  numRd: _presenter.userRes.rdChem,
                ),
                ItemGoldDetailView(
                  gbImg: _presenter.userRes.gbImg,
                  bgHImg: _presenter.userRes.bgHImg,
                  gbAvatar: _presenter.userRes.gbAvatar,
                  fSize: _presenter.userRes.fSize,
                  listModel: widget.listAll[3],
                  idUser: _presenter.userRes.user!.userId,
                  numList: widget.numList,
                  numRd: _presenter.userRes.rdBio,
                ),
                ItemGoldDetailView(
                  gbImg: _presenter.userRes.gbImg,
                  bgHImg: _presenter.userRes.bgHImg,
                  gbAvatar: _presenter.userRes.gbAvatar,
                  fSize: _presenter.userRes.fSize,
                  listModel: widget.listAll[4],
                  idUser: _presenter.userRes.user!.userId,
                  numList: widget.numList,
                  numRd: _presenter.userRes.rdEng,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
