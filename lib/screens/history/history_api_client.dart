import 'package:hava/models/history_model.dart';
import 'package:hava/src/lib_api.dart';

class HistoryApiClient extends ApiClient {
  HistoryApiClient(BuildContext context) : super(context);

  Future getHistory(int id, int page) async {
    final res =
        await apiNew.methodGet(api: '${ApiConfig.apiListHis}/$id/$page');
    if (res != null) return HistoryModelList.fromJson(res).list;
    return errHandle(res);
  }
}
