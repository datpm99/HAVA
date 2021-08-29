class ApiConfig {
  static const String baseUrl = 'http://192.168.1.53:8081/api/v1';

  //datpm 192.168.10.102
  //192.168.90.110
  //dung 192.168.1.53
  //hai 192.168.1.5

  //Api User.
  static const String apiActive = '$baseUrl/user/active';
  static const String apiCheckAc = '$baseUrl/user/active'; // /{userId}/{catId}
  static const String apiRegister = '$baseUrl/user/auth/register';
  static const String apiLogin = '$baseUrl/user/auth/signin';
  static const String apiSocial = '$baseUrl/user/auth/signin-social';
  static const String apiChangePass = '$baseUrl/user/changePassword';
  static const String apiCourse = '$baseUrl/user/course/'; // {id}
  static const String apiUpdate = '$baseUrl/user/update';

  //Api CheckEmail.
  static const String apiEmail = '$baseUrl/auth/email';
  static const String apiForgotPass = '$baseUrl/auth/email/forget-password';

  //Api Theory.
  static const String apiKnow = '$baseUrl/category/'; // {id}
  static const String apiSearch = '$baseUrl/search/'; // {key-word}
  static const String apiTheory = '$baseUrl/theory/'; // {id}

  //Api Documents.
  static const String apiDoc = '$baseUrl/documents'; // or /{id}

  //Api Exams.
  static const String apiAddExe = '$baseUrl/exam';
  static const String apiExam = '$baseUrl/exam/'; // {id}

  //Api Feels.
  static const String apiFeedback = '$baseUrl/feels';

  //Api fqas.
  static const String apiGuide = '$baseUrl/fqas';

  //Api Test-History.
  static const String apiListHis = '$baseUrl/history';
  static const String apiAddHistory = '$baseUrl/test-history';
  static const String apiTotalHis = '$baseUrl/test-history/'; // {id}

  //Api Question.
  static const String apiQuestion = '$baseUrl/questions/'; // {id}
  static const String apiRdExam = '$baseUrl/questions/random/'; // {id}

  //Api Test-Schedule.
  static const String apiSchedule = '$baseUrl/test-schedule';

  //Api Videos.
  static const String apiVideo = '$baseUrl/videos';

  //Api Rank.
  static const String apiRank = '$baseUrl/rank/'; //{idCat}

  //ApiNote.
  static const String apiListNote = '$baseUrl/user/list-note/'; //{page}
  static const String apiNote = '$baseUrl/user/note'; //{id}

  //Api Transcript.
  static const String apiTran = '$baseUrl/transcript'; // /{idTrans}/{term}
  static const String apiUpMark = '$baseUrl/transcript/mark'; // /{id}

}
