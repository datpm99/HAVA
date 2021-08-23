import 'package:hava/src/lib_api.dart';
import 'package:hava/models/guide_model.dart';

class GuideApiClient extends ApiClient {
  GuideApiClient(BuildContext context) : super(context);

  Future getGuide() async {
    final res = await apiNew.methodGet(api: ApiConfig.apiGuide);
    if (res != null) return GuideModelList.fromJson(res).list;
    return errHandle(res);
  }
}
