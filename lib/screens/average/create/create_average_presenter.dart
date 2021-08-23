import 'dart:convert';
import 'package:hava/models/tran_model.dart';
import 'package:hava/screens/average/bottom_sheet/average_sheet_view.dart';
import 'package:hava/screens/dialog/alert_result_dialog.dart';
import 'package:hava/src/lib_presenter.dart';
import '../average_api_client.dart';

class CreateAveragePresenter extends Presenter {
  CreateAveragePresenter(BuildContext context, Contract view)
      : super(context, view);
  TextEditingController txtName = TextEditingController();
  TextEditingController txtClass = TextEditingController();
  TextEditingController txtSlogan = TextEditingController();
  late AverageApiClient _apiClient;
  List<String> listSub = [];
  List<bool> listBoolRaw = [];
  List<bool> listBool = [];
  int isSub = 0;

  @override
  void init() {
    super.init();
    _apiClient = AverageApiClient(context);
    listSub.addAll(Utils.listSubject);
    listBool.addAll(Utils.listBoolSub);
    listBoolRaw.addAll(Utils.listBoolSub);
  }

  void onChangeSub() {
    showBottomSheet();
  }

  void onSubmit() async {
    String name = txtName.text.trim();
    String nameClass = txtClass.text.trim();
    String slogan = txtSlogan.text.trim();
    if (name.isEmpty) {
      Utils.showToast('Em chưa nhập tên!');
    } else if (name.length < 3 || name.length > 30) {
      Utils.showToast('Nhập tên có độ dài từ 3 - 30 ký tự!');
    } else if (!Utils.validateName(name)) {
      Utils.showToast('Tên không được chứa số và ký tự đặc biệt!');
    } else if (nameClass.isEmpty) {
      Utils.showToast('Em chưa nhập tên lớp!');
    } else if (nameClass.length < 3 || nameClass.length > 15) {
      Utils.showToast('Nhập tên lớp có độ dài từ 3 - 15 ký tự!');
    } else if (!Utils.validateClass(nameClass)) {
      Utils.showToast('Tên lớp không được chứa ký tự đặc biệt!');
    } else if (slogan.isEmpty) {
      Utils.showToast('Em chưa nhập câu slogan!');
    } else if (slogan.length < 3) {
      Utils.showToast('Câu slogan quá ngắn!');
    } else if (slogan.length > 100) {
      Utils.showToast('Câu slogan quá dài!');
    } else if (!Utils.validateSlogan(slogan)) {
      Utils.showToast('Câu slogan không được chứa ký tự đặc biệt!');
    } else {
      name = name.replaceAll(RegExp(r"\s+"), " ");
      nameClass = nameClass.replaceAll(RegExp(r"\s+"), " ");
      slogan = slogan.replaceAll(RegExp(r"\s+"), " ");
      List<String> listSubAdd = [];
      listSubAdd = checkListSub();
      showLoading();
      CreateTranModel model = CreateTranModel(
        name: name,
        classBelong: nameClass,
        title: slogan,
        listSub: listSubAdd,
      );
      await _apiClient.createTran(jsonEncode(model));
      await hideLoading();
      Utils.showToast('Tạo bảng điểm thành công!');
      onBack(value: true);
    }
  }

  void showBottomSheet() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      context: context,
      builder: (BuildContext context) {
        return AverageSheetView(
          listSub: listSub,
          listBool: listBoolRaw,
          onAddSubject: onAddSubject,
          onUpdate: onUpdate,
        );
      },
    );
  }

  void onAddSubject(String name) {
    bool isExits = false;
    for (int i = 0; i < listSub.length; i++) {
      if (listSub[i] == name) {
        isExits = true;
        break;
      }
    }
    if (isExits) {
      Utils.showToast("Môn học này đã tồn tại trong danh sách!");
    } else {
      listSub.add(name);
      listBoolRaw.add(true);
    }
  }

  List<String> checkListSub() {
    List<String> listRaw = [];
    for (int i = 0; i < listBool.length; i++) {
      if (listBool[i]) {
        listRaw.add(listSub[i]);
      }
    }
    return listRaw;
  }

  void onUpdate() {
    bool isTrue = false;
    for (int i = 0; i < listBoolRaw.length; i++) {
      if (listBoolRaw[i] == true) {
        isTrue = true;
        break;
      }
    }
    if (isTrue) {
      onBack();
      listBool.clear();
      listBool.addAll(listBoolRaw);
      view.updateState();
    } else {
      Utils.showToast('Em phải chọn ít nhất một môn học để tính điểm!');
    }
  }

  void dialogShowNotify(String name, Function() onTap) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
            title: 'Lời nhắc', content: name, cancel: onBack, ok: onTap);
      },
    );
  }

  void on2Back() {
    onBack();
    onBack(value: false);
  }

  void onBackAverage() {
    dialogShowNotify(Utils.notify9, on2Back);
  }

  Future<bool> onWillPopBack() async {
    return (await showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
          title: 'Lời nhắc',
          content: Utils.notify9,
          cancel: onBack,
          ok: on2Back,
        );
      },
    ));
  }
}
