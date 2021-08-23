import 'package:hava/models/note_model.dart';
import 'package:hava/src/lib_view.dart';
import 'package:hava/base/utils.dart';
import 'create_note_presenter.dart';

class CreateNoteView extends StatefulWidget {
  final bool isUpdate;
  final NoteModel model;

  const CreateNoteView({Key? key, required this.isUpdate, required this.model})
      : super(key: key);

  @override
  _CreateNoteViewState createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> implements Contract {
  late CreateNotePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter =
        CreateNotePresenter(context, this, widget.isUpdate, widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _presenter.onWillPopBack,
      child: Scaffold(
        appBar: AppBar(
          leading: VAll.leadingAppbar(_presenter.onBackNote),
          title: Text(_presenter.title),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nhập ghi chú của bạn', style: Styles.txtBlack(size: 14)),
              Container(
                margin: const EdgeInsets.only(bottom: 50, top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.5, color: Styles.colorG6),
                  color: _presenter.color,
                ),
                child: TextField(
                  controller: _presenter.txtController,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  autofocus: false,
                  decoration: const InputDecoration(
                    hintText: 'Ghi chú của bạn.',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text('Chọn màu nền', style: Styles.txtBlack(size: 14)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _btnColor(Utils.listColorNote[0], 0),
                  _btnColor(Utils.listColorNote[1], 1),
                  _btnColor(Utils.listColorNote[2], 2),
                  _btnColor(Utils.listColorNote[3], 3),
                  _btnColor(Utils.listColorNote[4], 4),
                  _btnColor(Utils.listColorNote[5], 5),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: VAll.btnUpdate(
            onTap: _presenter.onSubmit, name: _presenter.nameBtn),
      ),
    );
  }

  Widget _btnColor(Color color, int type) {
    return GestureDetector(
      onTap: () => _presenter.onChangeColor(type),
      child: Container(
        width: 100,
        height: 40,
        decoration: VAll.decoR5C(color),
        child: Icon(
          Icons.check,
          color: (_presenter.typeColor == type)
              ? Colors.white
              : Colors.transparent,
        ),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
