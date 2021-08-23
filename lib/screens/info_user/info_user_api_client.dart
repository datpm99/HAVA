import 'package:hava/src/lib_api.dart';

class InfoUserApiClient extends ApiClient {
  InfoUserApiClient(BuildContext context) : super(context);

  Future updateInfoUser(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiUpdate, body: body);
  }
}
