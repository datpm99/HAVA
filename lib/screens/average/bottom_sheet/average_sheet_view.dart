import 'package:hava/src/lib_view.dart';
import 'average_sheet_presenter.dart';

class AverageSheetView extends StatefulWidget {
  final List listSub, listBool;
  final Function onAddSubject, onUpdate;

  const AverageSheetView(
      {Key? key,
      required this.listSub,
      required this.listBool,
      required this.onAddSubject,
      required this.onUpdate})
      : super(key: key);

  @override
  _AverageSheetViewState createState() => _AverageSheetViewState();
}

class _AverageSheetViewState extends State<AverageSheetView>
    implements Contract {
  late AverageSheetPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = AverageSheetPresenter(context, this, widget.listSub,
        widget.listBool, widget.onAddSubject, widget.onUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: VAll.decoSheet(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VAll.sheetTitle(
            name: 'Chọn môn để tính điểm',
            onTap: _presenter.onBack,
            paddingS: _presenter.userRes.paddingS,
          ),
          const Divider(height: 1, color: Styles.colorG6),
          Row(
            children: [
              Expanded(
                child: VAll.sheetField(
                  name: 'Nhập tên môn',
                  txtName: _presenter.txtSub,
                  ver: _presenter.userRes.paddingS,
                ),
              ),
              _btnAdd(),
              const SizedBox(width: 10),
            ],
          ),
          _buildList(),
          VAll.btnUpdate(onTap: _presenter.onUpdateSheet),
        ],
      ),
    );
  }

  Widget _btnAdd() {
    return MaterialButton(
      onPressed: _presenter.addSubject,
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

  Widget _buildList() {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _presenter.listBool.length,
        itemBuilder: _buildItem,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1, color: Styles.colorG10),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: _presenter.listBool[index],
              onChanged: (value) =>
                  _presenter.onChange(value: value, index: index),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _presenter.listSub[index],
            style: Styles.copyStyle(color: Styles.colorG13),
          ),
        ],
      ),
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }
}
