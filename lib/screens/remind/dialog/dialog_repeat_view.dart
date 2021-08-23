import 'package:hava/src/lib_view.dart';
import 'dialog_repeat_presenter.dart';

class DialogRepeatView extends StatefulWidget {
  final List<int> listBox;
  final String timeAdd;
  final int idAdd;
  final int idUpdate;
  final String titleUpdate;

  const DialogRepeatView(
      {Key? key,
      required this.listBox,
      required this.timeAdd,
      required this.idAdd,
      required this.idUpdate,
      required this.titleUpdate})
      : super(key: key);

  @override
  _DialogRepeatViewState createState() => _DialogRepeatViewState();
}

class _DialogRepeatViewState extends State<DialogRepeatView>
    implements Contract {
  DialogRepeatPresenter? _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = DialogRepeatPresenter(context, this, widget.listBox,
        widget.timeAdd, widget.idAdd, widget.idUpdate, widget.titleUpdate);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter!.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 20, 0, 10),
                child: Text(
                  'Tiêu đề',
                  style: Styles.cusText(color: Colors.black87, size: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _presenter!.editingController,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tiêu đề',
                    contentPadding: EdgeInsets.only(left: 10, right: 10),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff989898),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 20, 0, 10),
                child: Text(
                  'Lặp lại',
                  style: Styles.cusText(color: Colors.black87, size: 18),
                ),
              ),
              _buildCheckBox(
                bol: _presenter!.mon,
                onTap: _presenter!.onMon,
                name: 'T2',
              ),
              _buildCheckBox(
                bol: _presenter!.tue,
                onTap: _presenter!.onTue,
                name: 'T3',
              ),
              _buildCheckBox(
                bol: _presenter!.wed,
                onTap: _presenter!.onWed,
                name: 'T4',
              ),
              _buildCheckBox(
                bol: _presenter!.thu,
                onTap: _presenter!.onThu,
                name: 'T5',
              ),
              _buildCheckBox(
                bol: _presenter!.fri,
                onTap: _presenter!.onFri,
                name: 'T6',
              ),
              _buildCheckBox(
                bol: _presenter!.sat,
                onTap: _presenter!.onSat,
                name: 'T7',
              ),
              _buildCheckBox(
                bol: _presenter!.sun,
                onTap: _presenter!.onSun,
                name: 'CN',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context,false),
                    child: Text('Hủy'),
                  ),
                  FlatButton(
                    onPressed: _presenter!.onOk,
                    child: Text('Lưu'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildCheckBox({bool bol=true, onTap, String name=''}) {
    return Row(
      children: [
        Checkbox(
          value: bol,
          onChanged:onTap,
          activeColor: Colors.deepOrange,
        ),
        const SizedBox(width: 10),
        Text(name),
      ],
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
