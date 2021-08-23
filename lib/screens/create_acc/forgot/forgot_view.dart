import 'package:hava/src/lib_view.dart';
import 'forgot_presenter.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({Key? key}) : super(key: key);

  @override
  ForgotViewState createState() => ForgotViewState();
}

class ForgotViewState extends State<ForgotView> implements Contract {
  late ForgotPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ForgotPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: VAll.boxImg('assets/images/bgScreen.png'),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              VAll.iconLogin(
                mrTop: _presenter.userRes.marTop,
                mrBot: _presenter.userRes.marBottom,
                hImg: _presenter.userRes.heightImg,
                width: width,
              ),
              Text(
                'Quên Mật Khẩu',
                style: Styles.txtBold(
                  color: Colors.white,
                  size: _presenter.userRes.titleTxt,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: VAll.fieldName(
                  name: 'Nhập Email',
                  con: _presenter.txtEmail,
                ),
              ),
              VAll.btnAcc(
                name: 'TIẾP TỤC',
                width: width,
                onTap: _presenter.onSubmit,
              ),
              _buildRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTxt(name: 'Đăng nhập', onTap: _presenter.onLogin),
        Text(
          ' hoặc ',
          style: Styles.copyStyle(color: Colors.white, fontSize: 12),
        ),
        _buildTxt(name: 'Đăng ký   ', onTap: _presenter.onRegister),
      ],
    );
  }

  Widget _buildTxt({String name = '', Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        name,
        style: Styles.copyStyle(color: Styles.colorY4, fontSize: 15),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
