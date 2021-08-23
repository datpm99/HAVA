import 'dart:convert';
import 'dialog_code.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/login_model.dart';
import 'package:hava/screens/create_acc/login/login_view.dart';
import 'package:hava/screens/create_acc/login/login_api_client.dart';

class RegisterPresenter extends Presenter {
  RegisterPresenter(BuildContext context, Contract view) : super(context, view);

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtRepass = TextEditingController();
  bool isPass = true;
  bool isRepass = true;
  int isGender = 1;
  DateTime? selectedDate;
  String dateShow = '';
  String dateAdd = '';

  late LoginApiClient _apiClient;

  @override
  void init() {
    super.init();
    _apiClient = LoginApiClient(context);
  }

  void showPass() {
    isPass = !isPass;
    view.updateState();
  }

  void showRepass() {
    isRepass = !isRepass;
    view.updateState();
  }

  void onChangeDate() {
    if (selectedDate != null) {
      dateShow =
          '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
      dateAdd =
          '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';
      txtDate.text = dateShow;
      view.updateState();
    }
  }

  void onChange(int? value) {
    isGender = value!;
    view.updateState();
  }

  bool validName(String name) {
    if (name.isEmpty) {
      Utils.showToast('Em chưa nhập tên!');
    } else if (name.length < 3) {
      Utils.showToast('Em nhập tên quá ngắn!');
    } else if (name.length > 100) {
      Utils.showToast('Em nhập tên quá dài!');
    } else if (!Utils.validateName(name)) {
      Utils.showToast('Tên không được chứa số và ký tự đặc biệt!');
    } else {
      return true;
    }
    return false;
  }

  bool validDate(String date) {
    if (date.isEmpty) {
      Utils.showToast('Em chưa nhập ngày sinh!');
    } else {
      return true;
    }
    return false;
  }

  bool validEmail(String email) {
    if (email.isEmpty) {
      Utils.showToast('Em chưa nhập email!');
    } else if (!Utils.validateEmail(email)) {
      Utils.showToast('Em nhập sai định dạng email!');
    } else if (email.length > 190) {
      Utils.showToast('Em nhập email quá dài');
    } else {
      return true;
    }
    return false;
  }

  bool validPass(String pass, String rePass) {
    if (pass.isEmpty) {
      Utils.showToast('Em chưa nhập mật khẩu!');
    } else if (pass.length < 6 || pass.length > 16) {
      Utils.showToast('Mật khẩu có độ dài 6-16 ký tự!');
    } else if (!Utils.validatePass(pass)) {
      Utils.showToast(
          'Mật khẩu không được chứa các ký tự đặc biệt và khoảng trắng!');
    } else if (rePass.isEmpty) {
      Utils.showToast('Em chưa nhập lại mật khẩu!');
    } else if (pass != rePass) {
      Utils.showToast('Mật khẩu không giống nhau!');
    } else {
      return true;
    }
    return false;
  }

  void onSubmit() async {
    String name = txtName.text.trim();
    String dob = txtDate.text.trim();
    String email = txtEmail.text.trim();
    String pass = txtPass.text;
    String rePass = txtRepass.text;

    if (validName(name) &&
        validDate(dob) &&
        validEmail(email) &&
        validPass(pass, rePass)) {
      showLoading();
      name = name.replaceAll(RegExp(r"\s+"), " ");
      RegisterModel model = RegisterModel(
        name: name,
        email: email,
        pass: pass,
        birthday: dateAdd,
        sex: isGender,
        fbID: -1,
        avatar: '',
      );
      SendEmailModel emailModel = SendEmailModel(toEmail: email);
      final code = await _apiClient.sendCodeByEmail(jsonEncode(emailModel));
      await hideLoading();
      if (code == 'Email already registered!') {
        Utils.showToast('Email đã được sự dụng cho tài khoản khác!');
      } else if (code == null) {
        Utils.showToast('Không thể sử dụng email này!');
      } else {
        final valid = await showDialog(
          context: context,
          builder: (context) => DialogCode(email: email, code: code),
        );
        if (valid) {
          Utils.showToast('Đăng ký tài khoản thành công!');
          await _apiClient.registerUser(jsonEncode(model));
          onLogin();
        }
      }
    }
  }

  void onLogin() {
    Utils.navigateNotBack(context, const LoginView());
  }
}
