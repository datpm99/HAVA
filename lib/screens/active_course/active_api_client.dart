import 'package:hava/src/lib_api.dart';

class ActiveApiClient extends ApiClient {
  ActiveApiClient(BuildContext context) : super(context);

  Future addCodeActive(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiActive, body: body);
  }
}
