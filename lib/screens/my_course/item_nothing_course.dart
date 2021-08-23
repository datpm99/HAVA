import 'package:flutter/gestures.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hava/base/const.dart';
import 'package:hava/base/utils.dart';
import 'package:hava/src/lib_view.dart';
import 'package:hava/screens/active_course/dialog_active.dart';
import 'package:hava/screens/active_course/active_course_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemNothingCourse extends StatelessWidget {
  const ItemNothingCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bạn chưa đăng ký môn học nào!',
            style: Styles.txtBlack(size: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 60),
            child: RichText(
              text: TextSpan(
                text: 'Vui lòng ',
                style: Styles.txtBlack(size: 16, height: 1.4),
                children: <TextSpan>[
                  TextSpan(
                    text: 'liên hệ',
                    style: Styles.txtBlack(size: 16, color: Styles.colorOr3),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => onContact(context),
                  ),
                  const TextSpan(
                    text: ' với chúng tôi để được hỗ trợ đăng ký cũng như ',
                  ),
                  TextSpan(
                    text: 'kích hoạt khoá học.',
                    style: Styles.txtBlack(size: 16, color: Styles.colorOr3),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => onActive(context),
                  ),
                ],
              ),
            ),
          ),
          Center(child: _imgActive()),
        ],
      ),
    );
  }

  Widget _imgActive() {
    return Image.asset('assets/images/bg_active.png', width: 200, height: 190);
  }

  void onContact(context) {
    showDialog(
      context: context,
      builder: (context) => DialogActive(
        onBack: () => onBack(context),
        onCallNumber: onCallNumber,
        onEmail: onEmail,
        onOpenMap: onOpenMap,
      ),
    );
  }

  void onBack(context) {
    Navigator.pop(context);
  }

  void onActive(context) {
    Utils.navigatePage(context, const ActiveCourseView());
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
