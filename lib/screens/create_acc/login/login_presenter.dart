import 'dart:math';
import 'dart:convert';
import 'package:hava/screens/info_user/info_user_view.dart';

import 'login_api_client.dart';
import 'package:hava/auth/bloc.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/user_model.dart';
import 'package:hava/models/login_model.dart';
import 'package:hava/pages/main/main_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hava/screens/create_acc/forgot/forgot_view.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:hava/screens/create_acc/register/register_view.dart';

class LoginPresenter extends Presenter {
  LoginPresenter(BuildContext context, Contract view) : super(context, view);

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  bool isPass = true;
  bool isRemember = false;
  late LoginApiClient _apiClient;

  @override
  void init() {
    super.init();
    _apiClient = LoginApiClient(context);
  }

  void showPass() {
    isPass = !isPass;
    view.updateState();
  }

  void onRemember(bool? value) {
    isRemember = value!;
    view.updateState();
  }

  String rdPass() {
    String pass = '';
    var rd = Random();
    for (int i = 0; i <= 5; i++) {
      pass += '${rd.nextInt(10)}';
    }
    return pass;
  }

  Future getSubActive(int idUser, InfoLgModel infoModel, int idSocial) async {
    bool isMath = await _apiClient.checkSubActive(idUser, 1);
    bool isPhysics = await _apiClient.checkSubActive(idUser, 2);
    bool isChemistry = await _apiClient.checkSubActive(idUser, 3);
    bool isBiology = await _apiClient.checkSubActive(idUser, 4);
    bool isEnglish = await _apiClient.checkSubActive(idUser, 5);
    bool isHistory = await _apiClient.checkSubActive(idUser, 6);
    bool isGeography = await _apiClient.checkSubActive(idUser, 7);
    bool isGDCD = await _apiClient.checkSubActive(idUser, 8);
    bool isLiterature = await _apiClient.checkSubActive(idUser, 9);
    UserModel model = UserModel(
      userId: idUser,
      userName: infoModel.entityModel.name,
      userEmail: infoModel.entityModel.email,
      userToken: infoModel.token,
      userPhone: infoModel.entityModel.phone,
      userAvatar: infoModel.entityModel.avatar,
      birthDay: infoModel.entityModel.birthday,
      sex: infoModel.entityModel.sex,
      isSocial: idSocial,
      isMath: isMath,
      isPhysics: isPhysics,
      isChemistry: isChemistry,
      isBiology: isBiology,
      isEnglish: isEnglish,
      isHistory: isHistory,
      isGeography: isGeography,
      isGDCD: isGDCD,
      isLiterature: isLiterature,
      address: infoModel.entityModel.address,
      school: infoModel.entityModel.school,
      classBelong: infoModel.entityModel.classBelong,
    );
    return model;
  }

  void onForgot() {
    Utils.navigateNotBack(context, ForgotView());
  }

  void onLogin() async {
    String name = txtEmail.text.trim();
    String pass = txtPass.text;
    if (name.isEmpty) {
      Utils.showToast('Em chưa nhập email!');
    } else if (!Utils.validateEmail(name)) {
      Utils.showToast('Em nhập sai định dạng email!');
    } else if (name.length > 190) {
      Utils.showToast('Em nhập email quá dài');
    } else if (pass.isEmpty) {
      Utils.showToast('Em chưa nhập mật khẩu!');
    } else if (!Utils.validatePass(pass)) {
      Utils.showToast(
          'Mật khẩu không được chứa các ký tự đặc biệt và khoảng trắng!');
    } else if (pass.length < 6 || pass.length > 16) {
      Utils.showToast('Mật khẩu có độ dài 6-16 ký tự!');
    } else {
      showLoading();
      LoginModel loginModel = LoginModel(username: name, password: pass);
      final modelRaw = await _apiClient.loginWithAcc(jsonEncode(loginModel));
      if (modelRaw != null) {
        InfoLgModel infoModel = InfoLgModel.fromJson(modelRaw);
        userRes.tokenRaw = infoModel.token;
        int idUser = infoModel.entityModel.id;
        UserModel model = await getSubActive(idUser, infoModel, 0);
        await hideLoading();
        if (isRemember) {
          userRes.isRemember = true;
          if (infoModel.entityModel.phone.isNotEmpty) {
            BlocProvider.of<AuthBloc>(context).add(LoginEvent(model));
          }
        } else {
          userRes.isRemember = false;
          userRes.user = model;
        }
        userRes.tokenRaw = '';
        if (infoModel.entityModel.phone.isNotEmpty) {
          Utils.navigateNotBack(context, MainView());
        } else {
          userRes.user = model;
          Utils.navigateNotBack(context, const InfoUserView(isFirstLg: true));
        }
      } else {
        await hideLoading();
        Utils.showToast('Tài khoản hoặc mật khẩu không đúng!');
      }
    }
  }

  void onFacebook() async {
    FacebookLogin fb = FacebookLogin();
    bool isLogin = await fb.isLoggedIn;
    if (isLogin) await fb.logOut();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Get profile data
        showLoading();
        FacebookUserProfile? fbProfile = await fb.getUserProfile();
        String userId = fbProfile!.userId;
        String? imgRaw = await fb.getProfileImageUrl(width: 100);
        List listImg = imgRaw!.split("/picture");
        String img = '${listImg[0]}/picture?type=normal';
        String? email = await fb.getUserEmail();
        email ??= '$userId@facebook.com';
        String pass = rdPass();

        LoginSocialModel fbModel = LoginSocialModel(
          name: fbProfile.name,
          email: email,
          pass: pass,
          fbID: 1,
          avatar: img,
        );
        final modelRaw = await _apiClient.loginSocial(jsonEncode(fbModel));
        if (modelRaw != null) {
          InfoLgModel infoModel = InfoLgModel.fromJson(modelRaw);
          userRes.tokenRaw = infoModel.token;
          int idUser = infoModel.entityModel.id;
          UserModel model = await getSubActive(idUser, infoModel, 1);
          await hideLoading();
          if (infoModel.entityModel.phone.isNotEmpty) {
            BlocProvider.of<AuthBloc>(context).add(LoginEvent(model));
            Utils.navigateNotBack(context, MainView());
          } else {
            userRes.user = model;
            Utils.navigateNotBack(context, const InfoUserView(isFirstLg: true));
          }
        } else {
          await hideLoading();
          Utils.showToast('Email đã được sử dụng cho một tài khoản khác!',
              isLong: true);
        }
        break;
      case FacebookLoginStatus.cancel:
        debugPrint('Cancel login FB');
        break;
      case FacebookLoginStatus.error:
        debugPrint('Error while log in: ${res.error}');
        break;
    }
  }

  void onGoogle() async {
    try {
      GoogleSignIn gg = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
      );
      bool isSignIn = await gg.isSignedIn();
      if (isSignIn) gg.disconnect();
      gg.signInSilently();
      GoogleSignInAccount? account = await gg.signIn();
      String email = account!.email;
      String pass = rdPass();

      showLoading();
      LoginSocialModel ggModel = LoginSocialModel(
        name: account.displayName,
        email: email,
        pass: pass,
        fbID: 0,
        avatar: '${account.photoUrl}',
      );
      final modelRaw = await _apiClient.loginSocial(jsonEncode(ggModel));
      if (modelRaw != null) {
        InfoLgModel infoModel = InfoLgModel.fromJson(modelRaw);
        userRes.tokenRaw = infoModel.token;
        int idUser = infoModel.entityModel.id;
        UserModel model = await getSubActive(idUser, infoModel, 1);
        await hideLoading();
        if (infoModel.entityModel.phone.isNotEmpty) {
          BlocProvider.of<AuthBloc>(context).add(LoginEvent(model));
          Utils.navigateNotBack(context, MainView());
        } else {
          userRes.user = model;
          Utils.navigateNotBack(context, const InfoUserView(isFirstLg: true));
        }
      } else {
        await hideLoading();
        Utils.showToast('Email đã được sử dụng cho một tài khoản khác!',
            isLong: true);
      }
    } catch (error) {
      debugPrint('$error');
    }
  }

  void onRegister() {
    Utils.navigateNotBack(context, RegisterView());
  }

  void reSize(double width, double height) {
    userRes.widthAll = width;
    userRes.heightAll = height;
    if (userRes.heightAll < 600) {
      userRes.marTop = 30;
      userRes.marBottom = 20;
      userRes.heightImg = 75;
      userRes.titleTxt = 24;
      userRes.icSize = 40;
      userRes.wGuide = 70;
      userRes.hGuide = 170;
      userRes.sizeTxt = 8;
      userRes.icImg1 = 50;
      userRes.wImg = 30;
      userRes.paddingS = 12;
      userRes.videoImg = 120;
      userRes.crossAxis = 10;
      userRes.mainAxis = 0;
      userRes.heightTxt = 1.2;
      userRes.gbImg = 180;
      userRes.gbAvatar = 25;
      userRes.bgHImg = 44;
      userRes.fSize = 10;
      userRes.cwImg = 30;
      userRes.chImg = 30;
      userRes.velSub = 5;
      userRes.heightBox = 0;
    }
  }
}
