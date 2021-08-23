import 'package:hava/models/tran_model.dart';
import 'package:hava/src/lib_view.dart';
import 'item_tab_presenter.dart';

class ItemTabView extends StatefulWidget {
  final MarkModel model;
  final int term, idTran;

  const ItemTabView(
      {Key? key, required this.model, required this.term, required this.idTran})
      : super(key: key);

  @override
  _ItemTabViewState createState() => _ItemTabViewState();
}

class _ItemTabViewState extends State<ItemTabView>
    with AutomaticKeepAliveClientMixin
    implements Contract {
  late ItemTabPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ItemTabPresenter(
        context, this, widget.model, widget.term, widget.idTran);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: _presenter.onChangeShow,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          decoration: VAll.decoRd5NonBr(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRowTxt(),
              Visibility(
                visible: _presenter.isShow,
                child: const SizedBox(height: 10),
              ),
              Visibility(
                visible: _presenter.isShow,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildConScope('Điểm miệng', _presenter.list1, 1),
                    _buildConScope('Điểm 15 phút', _presenter.list2, 2),
                    _buildConScope('Điểm 1 tiết', _presenter.list3, 3),
                    _buildConScope('Điểm thi', _presenter.list4, 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Widget View.

  Widget _buildRowTxt() {
    return Row(
      children: [
        Text(
          widget.model.subject,
          style: Styles.copyStyle(color: Styles.colorB4, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          _presenter.markAllShow,
          style: Styles.txtBold(color: Styles.colorB4, size: 16),
        ),
      ],
    );
  }

  Widget _buildConScope(String name, List<double> list, int type) {
    return GestureDetector(
      onTap: () => _presenter.showBottomSheet(list, type),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Styles.colorG15,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: Styles.colorG6),
        ),
        child: Column(
          children: [
            Text(name, style: Styles.cusText(size: 11, color: Styles.colorB5)),
            const SizedBox(height: 10),
            (list.isEmpty) ? _btnAddScope() : _btnViewScope(list),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _btnAddScope() {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: VAll.boxShadow(),
      ),
      child: const Icon(Icons.add, size: 20),
    );
  }

  Widget _btnViewScope(List<double> list) {
    return Wrap(runSpacing: 5, spacing: 5, children: _buildListGen(list));
  }

  List<Widget> _buildListGen(List<double> list) {
    List<Container> con = List<Container>.generate(list.length, (index) {
      String num =
          list[index].toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
      return Container(
        width: 27,
        height: 27,
        alignment: Alignment.center,
        decoration: VAll.decoNonShadow(Colors.white, 1.0, Styles.colorG10),
        child: Text(num, style: Styles.copyStyle(color: Styles.colorB4)),
      );
    });
    return con;
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
