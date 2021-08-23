import 'package:hava/models/tran_model.dart';
import 'package:hava/src/lib_api.dart';

class AverageApiClient extends ApiClient {
  AverageApiClient(BuildContext context) : super(context);

  Future getListTran() async {
    final res = await apiNew.methodGet(api: ApiConfig.apiTran);
    if (res != null) return TranModelList.fromJson(res).list;
    return errHandle(res);
  }

  Future createTran(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiTran, body: body);
  }

  Future getMarkByTerm(int idTran, int term) async {
    final res =
        await apiNew.methodGet(api: '${ApiConfig.apiTran}/$idTran/$term');
    if (res != null) return MarkModelList.fromJson(res).list;
    return errHandle(res);
  }

  Future updateMark(String body, int id) async {
    return await apiNew.methodPut(api: '${ApiConfig.apiUpMark}/$id', body: body);
  }

  Future deleteTran(int id) async {
    return await apiNew.methodDel(api: '${ApiConfig.apiTran}/$id');
  }
}
