import 'package:hava/src/lib_presenter.dart';

class AverageSheetPresenter extends Presenter {
  AverageSheetPresenter(BuildContext context, Contract view, this.listSub,
      this.listBool, this.onAddSubject, this.onUpdate)
      : super(context, view);

  TextEditingController txtSub = TextEditingController();
  final List listSub, listBool;
  final Function onAddSubject, onUpdate;

  void onChange({bool? value, int? index}) {
    listBool[index!] = value!;
    view.updateState();
  }

  void addSubject() {
    String sub = txtSub.text.trim();
    if (sub.isEmpty) {
      Utils.showToast('Em chưa nhập môn học');
    } else if (!Utils.validateName(sub)) {
      Utils.showToast('Tên môn học không được chứa số và ký tự đặc biệt!');
    } else if (sub.length < 3 || sub.length > 20) {
      Utils.showToast('Nhập tên môn học có độ dài từ 3 - 20 ký tự!');
    } else {
      sub = sub.replaceAll(RegExp(r"\s+"), " ");
      onAddSubject(sub);
      view.updateState();
    }
  }

  void onUpdateSheet() {
    onUpdate();
    //onBack();
  }
}
