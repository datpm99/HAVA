import 'package:hava/screens/dialog/alert_result_dialog.dart';
import 'package:hava/src/lib_presenter.dart';
import 'add_scope/add_scope_view.dart';
import 'average_api_client.dart';
import 'create/create_average_view.dart';
import 'item_average_view.dart';

class AveragePresenter extends Presenter {
  AveragePresenter(BuildContext context, Contract view) : super(context, view);

  late AverageApiClient _apiClient;

  @override
  void init() {
    super.init();
    _apiClient = AverageApiClient(context);
    userRes.isUpPoint = false;
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _apiClient.getListTran();
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      return ItemAverageView(
          model: list[index], onDelete: onDelete, onDetail: onAddScope);
    }
    return super.itemBuild(context, index);
  }

  Future dialogShowNotify() async {
    final result = await showDialog(
      context: context,
      builder: (_) {
        return AlertResultDialog(
          title: 'Lời nhắc',
          content: Utils.notify10,
          cancel: () => onBack(value: false),
          ok: () => onBack(value: true),
        );
      },
    );
    return result;
  }

  void onDelete(int id) async {
    final result = await dialogShowNotify();
    if (result == true) {
      await _apiClient.deleteTran(id);
      Utils.showToast('Xóa bảng điểm thành công!');
      list = await _apiClient.getListTran();
      view.updateState();
    }
  }

  void onAddScope(model) async {
    await Utils.navigatePage(context, AddScopeView(idTran: model.id));
    if (userRes.isUpPoint) {
      list = await _apiClient.getListTran();
      view.updateState();
    }
  }

  void onCreateAverage() async {
    final result = await Utils.navigatePage(context, const CreateAverageView());
    if (result == true) {
      list = await _apiClient.getListTran();
      view.updateState();
    }
  }
}
