import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dialog_active.dart';
import 'active_api_client.dart';
import 'package:hava/models/user_model.dart';
import 'package:hava/src/lib_presenter.dart';

class ActiveCoursePresenter extends Presenter {
  ActiveCoursePresenter(BuildContext context, Contract view)
      : super(context, view);
  TextEditingController txtActive = TextEditingController();

  late ActiveApiClient _apiClient;
  late bool isMath, isPhysics, isChemistry, isBiology, isEnglish, isLiterature;
  late bool isGeography, isGDCD, isHistory;

  @override
  void init() {
    super.init();
    _apiClient = ActiveApiClient(context);
  }

  void onContact() {
    showDialog(
      context: context,
      builder: (context) => DialogActive(
        onBack: onBack,
        onCallNumber: onCallNumber,
        onEmail: onEmail,
        onOpenMap: onOpenMap,
      ),
    );
  }

  void onActiveCourse() async {
    String txtCode = txtActive.text.trim();
    if (txtCode.isEmpty) {
      Utils.showToast('Em chưa nhập mã kích hoạt!');
    } else {
      showLoading();
      final mess = await _apiClient.addCodeActive(txtCode);
      if (mess ==
          'Đã kích hoạt thành công, vui lòng vào môn học đã kích hoạt để bắt đầu học trên Hava!') {
        int id = int.parse(txtCode.substring(2, 3));
        addValueBool();
        checkBoolSub(id);
        print('data : $isMath');
        UserModel userModel = UserModel(
          userId: userRes.user!.userId,
          userName: userRes.user!.userName,
          userEmail: userRes.user!.userEmail,
          userPhone: userRes.user!.userPhone,
          userAvatar: userRes.user!.userAvatar,
          birthDay: userRes.user!.birthDay,
          sex: userRes.user!.sex,
          userToken: userRes.user!.userToken,
          isSocial: 0,
          isMath: isMath,
          isPhysics: isPhysics,
          isChemistry: isChemistry,
          isBiology: isBiology,
          isEnglish: isEnglish,
          isLiterature: isLiterature,
          isGeography: isGeography,
          isGDCD: isGDCD,
          isHistory: isHistory,
          address: userRes.user!.address,
          school: userRes.user!.school,
          classBelong: userRes.user!.classBelong,
        );
        if (userRes.isRemember) {
          await userRes.updateUser(userModel);
        } else {
          userRes.user = userModel;
        }
      }
      await hideLoading();
      Utils.showToast('$mess', isLong: true);
    }
  }

  void checkBoolSub(int id) {
    if (id == 1) isMath = true;
    if (id == 2) isPhysics = true;
    if (id == 3) isChemistry = true;
    if (id == 4) isBiology = true;
    if (id == 5) isEnglish = true;
    if (id == 6) isHistory = true;
    if (id == 7) isGeography = true;
    if (id == 8) isGDCD = true;
    if (id == 9) isLiterature = true;
  }

  void addValueBool() {
    isMath = userRes.user!.isMath;
    isPhysics = userRes.user!.isPhysics;
    isChemistry = userRes.user!.isChemistry;
    isBiology = userRes.user!.isBiology;
    isEnglish = userRes.user!.isEnglish;
    isLiterature = userRes.user!.isLiterature;
    isGeography = userRes.user!.isGeography;
    isGDCD = userRes.user!.isGDCD;
    isHistory = userRes.user!.isHistory;
  }

  void onCallNumber() async {
    await launch('tel://${Const.phoneUs}');
  }

  void onEmail() async {
    final Email email = Email(
      body: 'Em có thắc mắc gì hãy gửi đến chúng tôi.',
      subject: 'Liên hệ với chúng tôi',
      recipients: [(Const.emailContactUs)],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  void onOpenMap() async {
    await launch(
        'https://www.google.com/maps/place/100+Ho%C3%A0ng+Qu%E1%BB%91c+Vi%E1%BB%87t,+Ngh%C4%A9a+%C4%90%C3%B4,+C%E1%BA%A7u+Gi%E1%BA%A5y,+H%C3%A0+N%E1%BB%99i,+Vi%E1%BB%87t+Nam/@21.0468891,105.793957,17z/data=!3m1!4b1!4m5!3m4!1s0x3135ab3acd90bde3:0x9aaa7d294397c5b9!8m2!3d21.0468891!4d105.7961457?hl=vi-VN');
  }
}
