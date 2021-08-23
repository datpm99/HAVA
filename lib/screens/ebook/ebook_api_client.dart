import 'package:hava/src/lib_api.dart';
import 'package:hava/models/doc_model.dart';

class EbookApiClient extends ApiClient {
  EbookApiClient(BuildContext context) : super(context);

  Future getDocById(int id) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiDoc}/$id');
    if (res != null) return DocModelList.fromJson(res).list;
    return errHandle(res);
  }
}
