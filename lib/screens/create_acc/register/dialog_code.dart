import 'dialog_code_presenter.dart';
import 'package:hava/src/lib_view.dart';

class DialogCode extends StatefulWidget {
  final String email;
  final String code;

  const DialogCode({Key? key, required this.email, required this.code})
      : super(key: key);

  @override
  State<DialogCode> createState() => _DialogCodeState();
}

class _DialogCodeState extends State<DialogCode> implements Contract {
  late DialogCodePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = DialogCodePresenter(context, this, widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 2),
          VAll.sheetTitle(
            name: 'Xác thực email',
            onTap: _presenter.onBackT,
            paddingS: 12.0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 2),
            child: Text(
              'Mã xác nhận đã được gửi đến email',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.email,
              style: Styles.cusText(color: Styles.colorB2),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
            child: Text(
              'Em vui lòng kiểm tra email và nhập mã vào ô dưới đây.',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: VAll.fieldName(
              name: 'Nhập mã xác nhận',
              con: _presenter.txtCode,
            ),
          ),
          _btnSubmit(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _btnSubmit() {
    return GestureDetector(
      onTap: _presenter.onSubmit,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Styles.colorOr3,
          boxShadow: VAll.boxShadow(),
        ),
        child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void updateState() {
    if (mounted) setState(() {});
  }
}
