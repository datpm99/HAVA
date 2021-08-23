import 'change_pass_presenter.dart';
import 'package:hava/src/lib_view.dart';

class ChangePassView extends StatefulWidget {
  const ChangePassView({Key? key}) : super(key: key);

  @override
  _ChangePassViewState createState() => _ChangePassViewState();
}

class _ChangePassViewState extends State<ChangePassView> implements Contract {
  late ChangePassPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ChangePassPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi mật khẩu')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset('assets/images/img_mk.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: VAll.fieldPass(
                name: 'Mật khẩu cũ',
                controller: _presenter.txtPass,
                pass: _presenter.isOldPass,
                onTap: _presenter.onOldPass,
              ),
            ),
            VAll.fieldPass(
              name: 'Mật khẩu mới',
              controller: _presenter.txtNewPass,
              pass: _presenter.isNewPass,
              onTap: _presenter.onNewPass,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: VAll.fieldPass(
                name: 'Nhập lại mật khẩu',
                controller: _presenter.txtReNewPass,
                pass: _presenter.isReNewPass,
                onTap: _presenter.onReNewPass,
              ),
            ),
            GestureDetector(
              onTap: _presenter.onUpdate,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 100,
                alignment: Alignment.center,
                decoration: VAll.decoRd30(Styles.colorMain),
                child: Text(
                  'Cập nhật',
                  style: Styles.cusText(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
