import 'package:hava/models/note_model.dart';
import 'package:hava/screens/dialog/alert_result_dialog.dart';
import 'package:hava/screens/note/note_api_client.dart';
import 'package:hava/src/lib_presenter.dart';
import 'create/create_note_view.dart';
import 'item_note_view.dart';

class NoteDialogPresenter extends Presenter {
  NoteDialogPresenter(BuildContext context, Contract view)
      : super(context, view);

  late NoteApiClient _apiClient;

  @override
  void init() {
    super.init();
    _apiClient = NoteApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _apiClient.getListNote();
    view.updateState();
  }

  @override
  void loadMore() async {
    super.loadMore();
    List obs = await _apiClient.getListNote();
    if (obs.isNotEmpty) {
      list.addAll(obs);
      view.updateState();
    }
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      NoteModel model = list[index];
      Color color = pickColorNote(model.themes);
      return ItemNoteView(
        color: color,
        onDelete: dialogShowNotify,
        model: model,
        onUpdate: onUpdateNote,
      );
    }
    return super.itemBuild(context, index);
  }

  Color pickColorNote(String themes) {
    Color color = Colors.white;
    if (themes == 'orange') color = Utils.listColorNote[0];
    if (themes == 'green') color = Utils.listColorNote[1];
    if (themes == 'pink') color = Utils.listColorNote[2];
    if (themes == 'violet') color = Utils.listColorNote[3];
    if (themes == 'blue') color = Utils.listColorNote[4];
    if (themes == 'gray') color = Utils.listColorNote[5];
    return color;
  }

  void onDelete(int id) async {
    await _apiClient.deleteNote(id);
    Utils.showToast('Xóa ghi chú thành công!');
    list = await _apiClient.getListNote(first: true);
    onBack();
    view.updateState();
  }

  void dialogShowNotify(int id) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
          title: 'Thông báo!',
          content: 'Em có chắc chắn muốn xóa ghi chú này không ?',
          cancel: onBack,
          ok: () => onDelete(id),
        );
      },
    );
  }

  void onUpdateNote(model) async {
    final result = await Utils.navigatePage(
        context, CreateNoteView(isUpdate: true, model: model));
    if (result == true) {
      list = await _apiClient.getListNote(first: true);
      view.updateState();
    }
  }

  void onCreateNote() async {
    NoteModel modelRaw = NoteModel(entry: '', id: 0, themes: '', title: '');
    final result = await Utils.navigatePage(
        context, CreateNoteView(isUpdate: false, model: modelRaw));
    if (result == true) {
      list = await _apiClient.getListNote(first: true);
      view.updateState();
    }
  }
}
