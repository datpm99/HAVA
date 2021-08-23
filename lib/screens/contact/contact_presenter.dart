import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPresenter extends Presenter {
  ContactPresenter(BuildContext context, Contract view) : super(context, view);

  void onCallNumber() async{
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
    await launch('https://www.google.com/maps/place/100+Ho%C3%A0ng+Qu%E1%BB%91c+Vi%E1%BB%87t,+Ngh%C4%A9a+%C4%90%C3%B4,+C%E1%BA%A7u+Gi%E1%BA%A5y,+H%C3%A0+N%E1%BB%99i,+Vi%E1%BB%87t+Nam/@21.0468891,105.793957,17z/data=!3m1!4b1!4m5!3m4!1s0x3135ab3acd90bde3:0x9aaa7d294397c5b9!8m2!3d21.0468891!4d105.7961457?hl=vi-VN');
  }
}
