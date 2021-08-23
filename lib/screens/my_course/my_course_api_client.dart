import 'package:hava/models/course_model.dart';
import 'package:hava/src/lib_api.dart';

class MyCourseApiClient extends ApiClient {
  MyCourseApiClient(BuildContext context) : super(context);

  Future getMyCourse(int id) async {
    final res = await apiNew.methodGet(api: '${ApiConfig.apiCourse}$id');
    if (res != null) return CourseModelList.fromJson(res).list;
    return errHandle(res);
  }
}
