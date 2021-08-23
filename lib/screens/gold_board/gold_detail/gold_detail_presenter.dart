import 'dart:math';
import 'package:hava/src/lib_presenter.dart';

class GoldDetailPresenter extends Presenter {
  GoldDetailPresenter(BuildContext context, Contract view)
      : super(context, view);

  @override
  void init() {
    super.init();
    var rd = Random();
    int num = rd.nextInt(10);
    userRes.rdMath += num;
    userRes.rdPhy += num;
    userRes.rdChem += num;
    userRes.rdBio += num;
    userRes.rdEng += num;
  }
}
