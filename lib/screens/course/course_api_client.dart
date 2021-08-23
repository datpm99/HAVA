import 'package:hava/models/exam_model.dart';
import 'package:hava/models/know_model.dart';
import 'package:hava/models/question_model.dart';
import 'package:hava/models/total_his_model.dart';
import 'package:hava/src/lib_api.dart';

class CourseApiClient extends ApiClient {
  CourseApiClient(BuildContext context) : super(context);

  Future getExams(int id) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiExam}$id');
    if (res != null) return ExamModelList.fromJson(res).list;
    return errHandle(res);
  }

  Future getQuestion(int idExam) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiQuestion}$idExam');
    if (res != null) return QuestionModelList.fromJson(res).list;
    return errHandle(res);
  }

  Future getRdExam(int idExam) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiRdExam}$idExam');
    if (res != null) return QuestionModelList.fromJson(res).list;
    return errHandle(res);
  }

  Future addHistory(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiAddHistory, body: body);
  }

  Future addExe(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiAddExe, body: body);
  }

  Future getTotal(int idHistory) async {
    final res =
        await apiNew.methodGet(api: '${ApiConfig.apiTotalHis}$idHistory');
    if (res != null) {
      List<TotalHisModel> list = TotalHisModelList.fromJson(res).list;
      return list;
    } else {
      return errHandle(res);
    }
  }

  Future getKnow(int idKnow) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiKnow}$idKnow');
    if (res != null) {
      List<KnowModel> list = KnowModelList.fromJson(res).list;
      return list;
    } else {
      return errHandle(res);
    }
  }

  Future getTheory(int idTheory) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiTheory}$idTheory');
    if (res != null) {
      KnowModel model = KnowModel.fromJson(res);
      return model;
    } else {
      return errHandle(res);
    }
  }
}
