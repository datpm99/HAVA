import 'package:hava/src/lib_api.dart';

class ChangePassApiClient extends ApiClient {
  ChangePassApiClient(BuildContext context) : super(context);

  Future changePass(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiChangePass, body: body);
  }
}
