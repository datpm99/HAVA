import 'package:hava/models/tran_model.dart';
import 'package:hava/src/lib_view.dart';
import 'tab3_presenter.dart';

class Tab3View extends StatefulWidget {
  final int idTran;

  const Tab3View({Key? key, required this.idTran}) : super(key: key);

  @override
  _Tab3ViewState createState() => _Tab3ViewState();
}

class _Tab3ViewState extends State<Tab3View> implements Contract {
  late Tab3Presenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = Tab3Presenter(context, this, widget.idTran);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildTitleTable(_buildTitle()),
        ),
        const Divider(height: 1, color: Styles.colorG5),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [_buildTitleTable(_buildListGen())],
          ),
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Styles.colorG15,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Điểm tổng kết cả năm',
                  style: Styles.copyStyle(color: Styles.colorB5),
                ),
              ),
              Text(
                _presenter.markShow,
                style: Styles.txtBold(color: Colors.redAccent, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Title Table.
  Widget _buildTitleTable(List<TableRow> list) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
      },
      children: list,
    );
  }

  List<TableRow> _buildTitle() {
    List<TableRow> tbRow = [];
    TableRow tb = TableRow(children: [
      _buildTxtTitle(name: 'Môn học'),
      _buildTxtTitle(name: 'HK1'),
      _buildTxtTitle(name: 'HK2'),
      _buildTxtTitle(name: 'Cả năm'),
    ]);
    tbRow.add(tb);
    return tbRow;
  }

  Widget _buildTxtTitle({String name = ''}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(name, style: Styles.txtBold(color: Styles.colorB5)),
    );
  }

  //Content Table.
  List<TableRow> _buildListGen() {
    List<TableRow> tbRow = List<TableRow>.generate(_presenter.list.length, (i) {
      MarkModel model = _presenter.list[i];
      return TableRow(children: [
        _buildTxt(name: model.subject, type: 2),
        _buildTxt(
            name: _presenter.listMTerm1[i].toStringAsPrecision(2), type: 1),
        _buildTxt(
            name: _presenter.listMTerm2[i].toStringAsPrecision(2), type: 1),
        _buildTxt(name: _presenter.listMAll[i].toStringAsPrecision(2), type: 1),
      ]);
    });
    return tbRow;
  }

  Widget _buildTxt({String name = '', int type = 1}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Styles.colorG6)),
      ),
      child: (type == 1)
          ? Text(name, style: Styles.txtBold(color: Styles.colorB4))
          : Text(name, style: Styles.copyStyle(color: Styles.colorB4)),
    );
  }

  @override
  void updateState() {
    // if (mounted)
    setState(() {});
  }
}
