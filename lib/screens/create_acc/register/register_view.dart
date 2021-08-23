import 'register_presenter.dart';
import 'package:hava/src/lib_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> implements Contract {
  late RegisterPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = RegisterPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: _presenter.userRes.widthAll,
        height: _presenter.userRes.heightAll,
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
                width: _presenter.userRes.widthAll,
              ),
              _txtTitle(),
              SizedBox(height: _presenter.userRes.marBottom),
              VAll.fieldName(name: 'Họ và tên', con: _presenter.txtName),
              const SizedBox(height: 15),
              _buildTxtDate(),
              VAll.fieldName(name: 'Email', con: _presenter.txtEmail),
              const SizedBox(height: 15),
              VAll.fieldPass(
                name: 'Mật khẩu',
                controller: _presenter.txtPass,
                pass: _presenter.isPass,
                onTap: _presenter.showPass,
              ),
              const SizedBox(height: 15),
              VAll.fieldPass(
                name: 'Nhập lại mật khẩu',
                controller: _presenter.txtRepass,
                pass: _presenter.isRepass,
                onTap: _presenter.showRepass,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _txtFont14(name: 'Giới tính :'),
                  _buildRadio(value: 1),
                  _txtFont14(name: 'Nam'),
                  const SizedBox(width: 6),
                  _buildRadio(value: 0),
                  _txtFont14(name: 'Nữ'),
                ],
              ),
              const SizedBox(height: 40),
              VAll.btnAcc(
                name: 'ĐĂNG KÝ',
                onTap: _presenter.onSubmit,
                width: _presenter.userRes.widthAll,
              ),
              _txtLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _txtTitle() {
    double size = _presenter.userRes.titleTxt;
    return Text(
      'Đăng Ký Tài Khoản',
      style: Styles.txtBold(color: Colors.white, size: size),
    );
  }

  Widget _txtLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _txtFont12(name: 'Bạn đã có tài khoản ? '),
        GestureDetector(
          onTap: _presenter.onLogin,
          child: _txtFont14(name: 'Đăng nhập ngay!', color: Styles.colorY4),
        ),
      ],
    );
  }

  Widget _txtFont14({name, Color color = Colors.white}) {
    return Text(name, style: Styles.copyStyle(color: color, fontSize: 14));
  }

  Widget _txtFont12({name, Color color = Colors.white}) {
    return Text(name, style: Styles.copyStyle(color: color, fontSize: 12));
  }

  Widget _buildTxtDate() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: VAll.decoRd5Non(),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: _presenter.txtDate,
        decoration: InputDecoration(
          hintText: ' Ngày sinh',
          hintStyle: Styles.copyStyle(color: Styles.colorG2),
          border: InputBorder.none,
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    _presenter.selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
        builder: (BuildContext? context, Widget? child) {
          return child ?? Container();
        });
    _presenter.onChangeDate();
  }

  Widget _buildRadio({int value = 0}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: SizedBox(
        width: 20,
        height: 20,
        child: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child: Radio(
            value: value,
            groupValue: _presenter.isGender,
            onChanged: _presenter.onChange,
          ),
        ),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
