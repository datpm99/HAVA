import 'dart:convert';
import 'package:hava/themes/styles.dart';
import 'package:hava/models/note_model.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/screens/note/note_api_client.dart';
import 'package:hava/screens/dialog/alert_result_dialog.dart';

class CreateNotePresenter extends Presenter {
  CreateNotePresenter(
      BuildContext context, Contract view, this.isUpdate, this.model)
      : super(context, view);

  final bool isUpdate;
  final NoteModel model;
  late NoteApiClient _apiClient;
  TextEditingController txtController = TextEditingController();
  Color color = Styles.colorNote5;
  int typeColor = 4;
  String nameBtn = 'Tạo ghi chú';
  String title = 'Tạo ghi chú';

  @override
  void init() {
    super.init();
    _apiClient = NoteApiClient(context);
    if (isUpdate) {
      txtController.text = model.entry;
      pickColorNote(model.themes);
      nameBtn = 'Cập nhật';
      title = 'Cập nhật ghi chú';
    }
  }

  void onChangeColor(int type) {
    if (type == 0) {
      color = Styles.colorNote1;
      typeColor = 0;
    } else if (type == 1) {
      color = Styles.colorNote2;
      typeColor = 1;
    } else if (type == 2) {
      color = Styles.colorNote3;
      typeColor = 2;
    } else if (type == 3) {
      color = Styles.colorNote4;
      typeColor = 3;
    } else if (type == 4) {
      color = Styles.colorNote5;
      typeColor = 4;
    } else if (type == 5) {
      color = Styles.colorNote6;
      typeColor = 5;
    }
    view.updateState();
  }

  void pickColorNote(String themes) {
    if (themes == 'orange') {
      color = Styles.colorNote1;
      typeColor = 0;
    }
    if (themes == 'green') {
      color = Styles.colorNote2;
      typeColor = 1;
    }
    if (themes == 'pink') {
      color = Styles.colorNote3;
      typeColor = 2;
    }
    if (themes == 'violet') {
      color = Styles.colorNote4;
      typeColor = 3;
    }
    if (themes == 'blue') {
      color = Styles.colorNote5;
      typeColor = 4;
    }
    if (themes == 'gray') {
      color = Styles.colorNote6;
      typeColor = 5;
    }
  }

  void onSubmit() async {
    String content = txtController.text.trim();
    String title = '';
    if (content.isEmpty) {
      Utils.showToast('Em chưa nhập ghi chú!');
    } else {
      if (content.length > 20) title = content.substring(0, 20);
      if (content.length <= 20) title = content;
      String color = Utils.stringColorNote[typeColor];
      CreateNote modelNote =
          CreateNote(entry: content, themes: color, title: title);
      showLoading();
      if (isUpdate) {
        await _apiClient.updateNote(jsonEncode(modelNote), model.id);
        await hideLoading();
        Utils.showToast('Cập nhập ghi chú thành công!');
        onBack(value: true);
      } else {
        await _apiClient.createNote(jsonEncode(modelNote));
        await hideLoading();
        Utils.showToast('Tạo ghi chú thành công!');
        onBack(value: true);
      }
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

  void onBackNote() {
    dialogShowNotify(Utils.notify8, on2Back);
  }

  Future<bool> onWillPopBack() async {
    return (await showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
          title: 'Lời nhắc',
          content: Utils.notify8,
          cancel: onBack,
          ok: on2Back,
        );
      },
    ));
  }
}
