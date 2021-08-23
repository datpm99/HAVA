import 'package:hava/src/lib_api.dart';
import 'package:hava/models/feedback_model.dart';

class HomeApiClient extends ApiClient {
  HomeApiClient(BuildContext context) : super(context);

  Future getFeedBack() async {
    final res = await apiNew.methodGet(api: ApiConfig.apiFeedback);
    if (res != null) return FeedBackModelList.fromJson(res).list;
    return errHandle(res);
  }

  Future getSchedule() async {
    final res = await apiNew.methodGet(api: ApiConfig.apiSchedule);
    if (res != null) return res;
    return errHandle(res);
  }
}
