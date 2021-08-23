import 'package:hava/src/lib_presenter.dart';

class AddMarkSheetPresenter extends Presenter {
  AddMarkSheetPresenter(BuildContext context, Contract view, this.type,
      this.onDelMark, this.onAddMark, this.onUpMark)
      : super(context, view);

  TextEditingController txtName = TextEditingController();
  final int type;
  final Function onDelMark, onAddMark, onUpMark;

  void onDelete(int index) {
    onDelMark(index);
    view.updateState();
  }

  void onAdd() {
    String mark = txtName.text.trim();
    if (mark.isEmpty) {
      Utils.showToast('Em chưa nhập điểm!');
    } else if (mark.length > 5) {
      Utils.showToast('Em nhập điểm quá dài!');
    } else if (!Utils.validateDouble(mark)) {
      Utils.showToast('Em nhập sai điểm!');
    }
    else {
      double markAdd = double.parse(mark);
      if (markAdd > 10) {
        Utils.showToast('Em nhập điểm quá lớn!');
      }else{
        print('vao dd');
        txtName.text = '';
        onAddMark(markAdd);
        view.updateState();
      }
    }
  }

  void onUpdate() {
    onUpMark(type);
  }
}
