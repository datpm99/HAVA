import 'dart:convert';
import 'forgot_dialog.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/login_model.dart';
import 'package:hava/screens/create_acc/login/login_view.dart';
import 'package:hava/screens/create_acc/register/register_view.dart';
import 'package:hava/screens/create_acc/login/login_api_client.dart';

class ForgotPresenter extends Presenter {
  ForgotPresenter(BuildContext context, Contract view) : super(context, view);
  TextEditingController txtEmail = TextEditingController();
  late LoginApiClient _apiClient;
  String storeEmail = '';

  @override
  void init() {
    super.init();
    _apiClient = LoginApiClient(context);
  }

  void onSubmit() async {
    String email = txtEmail.text.trim();
    if (email.isEmpty) {
      Utils.showToast('Em chưa nhập email!');
    } else if (!Utils.validateEmail(email)) {
      Utils.showToast('Em nhập sai email!');
    } else if (email.length > 190) {
      Utils.showToast('Em nhập email quá dài');
    } else {
      if (email != storeEmail) {
        showLoading();
        SendEmailModel emailModel = SendEmailModel(toEmail: email);
        final result = await _apiClient.forgotPass(jsonEncode(emailModel));
        await hideLoading();
        if (result == 'Hãy kiểm tra email của bạn!') {
          storeEmail = email;
          showForgotDialog(email);
        } else {
          Utils.showToast('$result', isLong: true);
        }
      } else {
        showForgotDialog(email);
      }
    }
  }

  void showForgotDialog(String email) {
    showDialog(
      context: context,
      builder: (context) => ForgotDialog(email: email),
    );
  }

  void onLogin() {
    Utils.navigateNotBack(context, const LoginView());
  }

  void onRegister() {
    Utils.navigateNotBack(context, const RegisterView());
  }
}
