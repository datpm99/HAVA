import 'item_my_course_view.dart';
import 'my_course_api_client.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/course_model.dart';
import 'package:hava/screens/course/course_view.dart';

class MyCoursePresenter extends Presenter {
  MyCoursePresenter(BuildContext context, Contract view, this.isMyCourse)
      : super(context, view);

  late MyCourseApiClient _apiClient;
  final bool isMyCourse;

  @override
  void init() {
    super.init();
    _apiClient = MyCourseApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _apiClient.getMyCourse(userRes.user!.userId);
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      CourseModel model = list[index];
      return ItemMyCourseView(model: model, onCourse: onCourse);
    }
    return super.itemBuild(context, index);
  }

  void onCourse(int type) {
    String sub = '';
    String img = '';
    int id = 0;
    switch (type) {
      case 0:
        sub = 'Toán học';
        img = 'assets/icons/ic_sub1.png';
        id = 1;
        break;
      case 1:
        sub = 'Vật lý';
        img = 'assets/icons/ic_sub22.png';
        id = 2;
        break;
      case 2:
        sub = 'Hóa học';
        img = 'assets/icons/ic_sub3.png';
        id = 3;
        break;
      case 3:
        sub = 'Sinh học';
        img = 'assets/icons/ic_sub9.png';
        id = 4;
        break;
      case 4:
        sub = 'Tiếng anh';
        img = 'assets/icons/ic_sub8.png';
        id = 5;
        break;
      case 5:
        sub = 'Ngữ văn';
        img = 'assets/icons/ic_sub6.png';
        id = 9;
        break;
      case 6:
        sub = 'Địa lý';
        img = 'assets/icons/ic_sub5.png';
        id = 7;
        break;
      case 7:
        sub = 'GDCD';
        img = 'assets/icons/ic_sub7.png';
        id = 8;
        break;
      case 8:
        sub = 'Lịch Sử';
        img = 'assets/icons/ic_sub4.png';
        id = 6;
        break;
    }
    Utils.navigatePage(context, CourseView(sub: sub, img: img, id: id));
  }
}
