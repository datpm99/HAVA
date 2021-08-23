import 'package:hava/src/lib_api.dart';
import 'package:hava/models/doc_model.dart';

class DocApiClient extends ApiClient {
  DocApiClient(BuildContext context) : super(context);

  Future getDoc() async {
    final res = await apiNew.methodGet(api: ApiConfig.apiDoc);
    if (res != null) return DocModelList.fromJson(res).list;
    return errHandle(res);
  }
}
