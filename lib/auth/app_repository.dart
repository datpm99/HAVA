import 'package:hava/models/question_model.dart';
import 'package:hava/models/user_model.dart';
import 'package:hive/hive.dart';

class UserRepository {
  List<int> answerMBT = [];
  List<int> listAnswerExe = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<int> listAnswerResult = [];
  int qsChoice = 0;
  int numQuesEng = 0;

  //List Mark.
  List listTerm1 = [];
  List listTerm2 = [];
  bool isUpPoint = false;
  List<QuestionModel> listQuesHive = [];

  //Random user gold broad.
  int rdMath = 504;
  int rdPhy = 526;
  int rdChem = 465;
  int rdBio = 602;
  int rdEng = 483;

  ///Resize
  //All.
  double widthAll = 0;
  double heightAll = 0;
  double heightTxt = 1;

  //Login Screen.
  double marTop = 50;
  double marBottom = 40;
  double heightImg = 95;
  double titleTxt = 28;
  double icSize = 50;

  //Home Screen.
  double wGuide = 100;
  double hGuide = 200;
  double sizeTxt = 10;

  //Document Screen.
  double icImg1 = 65;
  double wImg = 0;

  //Schedule Screen.
  double paddingS = 20;

  //Video Screen.
  double videoImg = 140;

  //Ebook Screen.
  double crossAxis = 15;
  double mainAxis = 15;

  //Gold_board Screen.
  double gbImg = 220;
  double gbAvatar = 30;
  double bgHImg = 48;
  double fSize = 12;

  //Course Screen.
  double cwImg = 70;
  double chImg = 35;
  double velSub = 15;
  double heightBox = 10;

  //Login.
  final String _loginKey = '_loginKey';
  String tokenRaw = '';
  Box? box;
  UserModel? user;
  bool isRemember = false;
  bool isUpdateInfo = false;

  Future init() async {
    box = await Hive.openBox(_loginKey);
    user = box!.get(_loginKey);
    isRemember = true;
  }

  Future login(UserModel model) async {
    user = model;
    box ??= await Hive.openBox(_loginKey);
    return box!.put(_loginKey, user);
  }

  Future logout() async {
    user = null;
    box ??= await Hive.openBox(_loginKey);
    box!.put(_loginKey, null);
  }

  Future updateUser(UserModel model) async {
    user = model;
    box ??= await Hive.openBox(_loginKey);
    await box!.put(_loginKey, user);
  }

  Future deleteBox() async {
    box ??= await Hive.openBox(_loginKey);
    box!.put(_loginKey, null);
  }
}
