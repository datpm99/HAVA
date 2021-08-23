import 'dart:convert';
import 'change_pass_api_client.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/login_model.dart';

class ChangePassPresenter extends Presenter {
  ChangePassPresenter(BuildContext context, Contract view)
      : super(context, view);

  TextEditingController txtPass = TextEditingController();
  TextEditingController txtNewPass = TextEditingController();
  TextEditingController txtReNewPass = TextEditingController();
  late ChangePassApiClient _apiClient;
  bool isOldPass = true;
  bool isNewPass = true;
  bool isReNewPass = true;

  @override
  void init() {
    super.init();
    _apiClient = ChangePassApiClient(context);
  }

  void onOldPass() {
    isOldPass = !isOldPass;
    view.updateState();
  }

  void onNewPass() {
    isNewPass = !isNewPass;
    view.updateState();
  }

  void onReNewPass() {
    isReNewPass = !isReNewPass;
    view.updateState();
  }

  void onUpdate() async {
    String pass = txtPass.text;
    String newPass = txtNewPass.text;
    String rePass = txtReNewPass.text;
    if (pass.isEmpty) {
      Utils.showToast('Em chưa nhập mật khẩu cũ!');
    } else if (!Utils.validatePass(pass)) {
      Utils.showToast(
          'Mật khẩu không được chứa các ký tự đặc biệt và khoảng trắng!');
    } else if (pass.length < 6 || pass.length > 16) {
      Utils.showToast('Mật khẩu có độ dài 6-16 ký tự!');
    } else if (newPass.isEmpty) {
      Utils.showToast('Em chưa nhập mật khẩu mới!');
    } else if (!Utils.validatePass(newPass)) {
      Utils.showToast(
          'Mật khẩu không được chứa các ký tự đặc biệt và khoảng trắng!');
    } else if (newPass.length < 6 || newPass.length > 16) {
      Utils.showToast('Mật khẩu có độ dài 6-16 ký tự!');
    } else if (rePass.isEmpty) {
      Utils.showToast('Em chưa nhập lại mật khẩu mới!');
    } else if (newPass != rePass) {
      Utils.showToast('Em nhập mật khẩu mới không giống nhau!');
    } else {
      showLoading();
      ChangePassModel model = ChangePassModel(newPw: newPass, oldPw: pass);
      final mess = await _apiClient.changePass(jsonEncode(model));
      if (userRes.isRemember) await userRes.deleteBox();
      await hideLoading();
      print(mess);
      if (mess == 'Password input is incorrect') {
        Utils.showToast('Em nhập sai mật khẩu!');
      } else {
        Utils.showToast('Đổi mật khẩu thành công!', isLong: true);
        txtPass.text = '';
        txtNewPass.text = '';
        txtReNewPass.text = '';
      }
    }
  }
}
