import 'package:hava/src/lib_presenter.dart';

class DialogCodePresenter extends Presenter {
  DialogCodePresenter(BuildContext context, Contract view, this.code)
      : super(context, view);

  final String code;
  TextEditingController txtCode = TextEditingController();

  void onSubmit() {
    String codeU = txtCode.text;
    if (codeU.isEmpty) {
      Utils.showToast('Em chưa nhập mã xác nhận!');
    } else {
      if (code == codeU) {
        Navigator.of(context).pop(true);
      } else {
        Utils.showToast('Em nhập sai mã xác nhận!');
      }
    }
  }

  void onBackT() {
    Navigator.of(context).pop(false);
  }
}
