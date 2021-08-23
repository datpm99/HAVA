import 'login_presenter.dart';
import 'package:hava/src/lib_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> implements Contract {
  late LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _presenter.reSize(width, height);
    return Scaffold(
      body: Container(
        width: _presenter.userRes.widthAll,
        height: _presenter.userRes.heightAll,
        decoration: VAll.boxImg22('assets/images/bgScreen.png'),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              VAll.iconLogin(
                mrTop: _presenter.userRes.marTop,
                mrBot: _presenter.userRes.marBottom,
                hImg: _presenter.userRes.heightImg,
                width: _presenter.userRes.widthAll,
              ),
              _txtTitle(),
              Container(
                margin: EdgeInsets.only(
                    top: _presenter.userRes.marBottom, bottom: 15),
                child: VAll.fieldName(name: 'Email', con: _presenter.txtEmail),
              ),
              VAll.fieldPass(
                name: 'Mật khẩu',
                controller: _presenter.txtPass,
                pass: _presenter.isPass,
                onTap: _presenter.showPass,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: _presenter.userRes.marTop),
                child: _rowForgotPass(),
              ),
              VAll.btnAcc(
                name: 'ĐĂNG NHẬP',
                onTap: _presenter.onLogin,
                width: _presenter.userRes.widthAll,
              ),
              txtFont12(name: 'Hoặc sử dụng'),
              _loginSocial(),
              _txtRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _txtTitle() {
    double size = _presenter.userRes.titleTxt;
    return Text(
      'Đăng Nhập',
      style: Styles.txtBold(color: Colors.white, size: size),
    );
  }

  Widget _rowForgotPass() {
    return Row(
      children: [
        VAll.cBox(context, _presenter.isRemember, _presenter.onRemember),
        const SizedBox(width: 5),
        Expanded(child: txtFont12(name: 'Nhớ đăng nhập')),
        GestureDetector(
          onTap: _presenter.onForgot,
          child: txtFont12(name: 'Quên mật khẩu?'),
        )
      ],
    );
  }

  Widget _loginSocial() {
    return Padding(
      padding: const EdgeInsets.only(top: 13, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _btnImg(
            img: 'assets/images/facebook.png',
            onTap: _presenter.onFacebook,
          ),
          const SizedBox(width: 20),
          _btnImg(
            img: 'assets/images/google.png',
            onTap: _presenter.onGoogle,
          ),
        ],
      ),
    );
  }

  Widget _txtRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        txtFont12(name: 'Bạn chưa có tài khoản ? '),
        GestureDetector(
          onTap: _presenter.onRegister,
          child: txtFont12(name: 'Đăng ký ngay !', color: Styles.colorY4),
        ),
      ],
    );
  }

  Widget txtFont12({String name = '', Color color = Colors.white}) {
    return Text(name, style: Styles.copyStyle(color: color, fontSize: 13));
  }

  Widget _btnImg({String img = '', Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        img,
        width: _presenter.userRes.icSize,
        height: _presenter.userRes.icSize,
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
