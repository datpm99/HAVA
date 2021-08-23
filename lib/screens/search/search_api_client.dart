import 'package:hava/models/search_model.dart';
import 'package:hava/src/lib_api.dart';

class SearchApiClient extends ApiClient {
  SearchApiClient(BuildContext context) : super(context);

  Future getSearch(String key) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiSearch}$key');
    if (res != null) return SearchModelList.fromJson(res).list;
    return errHandle(res);
  }
}
