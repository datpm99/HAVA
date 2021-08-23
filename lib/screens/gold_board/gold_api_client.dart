import 'package:hava/models/gold_broad_model.dart';
import 'package:hava/src/lib_api.dart';

class GoldApiClient extends ApiClient {
  GoldApiClient(BuildContext context) : super(context);

  Future getGoldBroad(int id) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiRank}$id');
    if (res != null) return GoldBroadModelList.fromJson(res).list;
    if (res == null) return errHandle(res);
  }

  Future checkExam(int id) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiSchedule}/$id');
    if (res != null) return res;
    return errHandle(res);
  }
}
