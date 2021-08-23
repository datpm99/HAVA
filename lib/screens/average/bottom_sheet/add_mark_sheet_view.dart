import 'package:hava/src/lib_view.dart';
import 'add_mark_sheet_presenter.dart';

class AddMarkSheetView extends StatefulWidget {
  final List<double> list;
  final int type;
  final Function onDelMark, onAddMark, onUpMark;

  const AddMarkSheetView({
    Key? key,
    required this.list,
    required this.type,
    required this.onDelMark,
    required this.onAddMark,
    required this.onUpMark,
  }) : super(key: key);

  @override
  _AddMarkSheetViewState createState() => _AddMarkSheetViewState();
}

class _AddMarkSheetViewState extends State<AddMarkSheetView>
    implements Contract {
  late AddMarkSheetPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = AddMarkSheetPresenter(context, this, widget.type,
        widget.onDelMark, widget.onAddMark, widget.onUpMark);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: VAll.decoSheet(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VAll.sheetTitle(
            name: 'Nhập điểm',
            onTap: _presenter.onBack,
            paddingS: _presenter.userRes.paddingS,
          ),
          const Divider(height: 1, color: Styles.colorG6),
          Row(
            children: [
              Expanded(
                child: VAll.sheetField(
                  name: 'Nhập điểm',
                  txtName: _presenter.txtName,
                  ver: _presenter.userRes.paddingS,
                ),
              ),
              _btnAdd(),
              const SizedBox(width: 10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              'Danh sách điểm đã nhập',
              style: Styles.cusText(color: Styles.colorG1),
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Styles.colorG15,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _listGenScope(),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          VAll.btnUpdate(onTap: _presenter.onUpdate),
        ],
      ),
    );
  }

  Widget _btnAdd() {
    return MaterialButton(
      onPressed: _presenter.onAdd,
      elevation: 2.0,
      height: 0,
      minWidth: 0,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      splashColor: Colors.black12,
      child: const Icon(Icons.add),
      shape: const CircleBorder(),
    );
  }

  List<Widget> _listGenScope() {
    List<Container> con = List<Container>.generate(widget.list.length, (index) {
      String num = widget.list[index]
          .toString()
          .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(num),
            const SizedBox(width: 5),
            _btnDelete(index),
          ],
        ),
      );
    });
    return con;
  }

  Widget _btnDelete(int index) {
    return GestureDetector(
      onTap: () => _presenter.onDelete(index),
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Styles.colorG15,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.clear, color: Colors.grey, size: 14),
      ),
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }
}
