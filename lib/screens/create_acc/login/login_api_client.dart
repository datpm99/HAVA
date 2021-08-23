import 'package:hava/src/lib_api.dart';

class LoginApiClient extends ApiClient {
  LoginApiClient(BuildContext context) : super(context);

  Future loginWithAcc(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiLogin, body: body);
  }

  Future loginSocial(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiSocial, body: body);
  }

  Future sendCodeByEmail(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiEmail, body: body);
  }

  Future registerUser(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiRegister, body: body);
  }

  Future checkSubActive(int idUser, int idCate) async {
    final res =
        await apiNew.methodGet(api: '${ApiConfig.apiCheckAc}/$idUser/$idCate');
    if (res != null) return res;
    return errHandle(res);
  }

  Future forgotPass(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiForgotPass, body: body);
  }
}
