import 'package:hava/src/lib_view.dart';
import 'note_dialog_presenter.dart';

class NoteDialogView extends StatefulWidget {
  const NoteDialogView({Key? key}) : super(key: key);

  @override
  _NoteDialogViewState createState() => _NoteDialogViewState();
}

class _NoteDialogViewState extends State<NoteDialogView> implements Contract {
  late NoteDialogPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = NoteDialogPresenter(context, this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _presenter.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VAll.sheetTitle(
            name: 'Danh sách ghi chú',
            onTap: _presenter.onBack,
            paddingS: 15.0,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _presenter.controller,
              itemCount: _presenter.list.length + 1,
              itemBuilder: _presenter.itemBuilder,
            ),
          ),
          _btnCreateNote(),
        ],
      ),
    );
  }

  Widget _btnCreateNote() {
    return GestureDetector(
      onTap: _presenter.onCreateNote,
      child: Container(
        height: 40,
        width: 120,
        margin: const EdgeInsets.only(bottom: 20, top: 20),
        alignment: Alignment.center,
        decoration: VAll.decoR5C(Styles.colorOr3),
        child: Text('Tạo ghi chú', style: Styles.cusText()),
      ),
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }
}
