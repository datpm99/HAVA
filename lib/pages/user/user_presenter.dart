import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/auth/auth_bloc.dart';
import 'package:hava/auth/auth_event.dart';
import 'package:hava/base/const.dart';
import 'package:hava/screens/active_course/test_view.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hava/screens/active_course/active_course_view.dart';
import 'package:hava/screens/change_pass/change_pass_view.dart';
import 'package:hava/screens/contact/contact_view.dart';
import 'package:hava/screens/create_acc/login/login_view.dart';
import 'package:hava/screens/history/history_view.dart';
import 'package:hava/screens/info_user/info_user_view.dart';
import 'package:hava/screens/introduction/introduction_view.dart';
import 'package:hava/screens/my_course/my_course_view.dart';
import 'package:share/share.dart';

class UserPresenter extends Presenter {
  UserPresenter(BuildContext context, Contract view) : super(context, view);

  bool isChangePass = true;

  @override
  void init() {
    super.init();
    if (userRes.user!.isSocial == 1) isChangePass = false;
  }

  void onInfoUser() async {
    await Utils.navigatePage(context, const InfoUserView(isFirstLg: false));
    if (userRes.isUpdateInfo) view.updateState();
  }

  void onIntroduction() {
    Utils.navigatePage(context, const IntroductionView());
  }

  void onActivate() {
    Utils.navigatePage(context, const ActiveCourseView());
  }

  void onMyCourse() {
    bool isMyCourse = false;
    if (userRes.user!.isMath ||
        userRes.user!.isPhysics ||
        userRes.user!.isChemistry ||
        userRes.user!.isBiology ||
        userRes.user!.isEnglish ||
        userRes.user!.isGDCD ||
        userRes.user!.isHistory ||
        userRes.user!.isLiterature ||
        userRes.user!.isGeography) {
      isMyCourse = true;
    }
    Utils.navigatePage(context, MyCourseView(isMyCourse: isMyCourse));
  }

  void onHistory() {
    Utils.navigatePage(context, const HistoryView());
  }

  void onContact() {
    Utils.navigatePage(context, const ContactView());
    //Utils.navigatePage(context, const TestView());
  }

  void onShare() {
    if (Const.linkShareApp.isNotEmpty) {
      Share.share(
        'Tải ngay App Hava Education tại: ${Const.linkShareApp}',
        subject: 'Hava Education',
      );
    }
  }

  void onEmail() async {
    final Email email = Email(
      body: 'Góp ý với chúng tôi',
      subject: '${Const.appName} feedback',
      recipients: [(Const.emailContactUs)],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  void onChangePass() {
    Utils.navigatePage(context, const ChangePassView());
  }

  void onSignOut() async {
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
    Utils.navigateNotBack(context, const LoginView());
  }
}
