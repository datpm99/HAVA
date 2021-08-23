import 'package:hava/models/know_model.dart';
import 'package:hava/screens/course/course_api_client.dart';
import 'package:hava/screens/course/knowledge/lesson/lesson_view.dart';
import 'package:hava/src/lib_presenter.dart';

class ItemKnowledgePresenter extends Presenter {
  ItemKnowledgePresenter(
      BuildContext context, Contract view, this.model, this.sub, this.idSub)
      : super(context, view);

  //Data Final.
  final KnowModel model;
  final String sub;
  final int idSub;
  late CourseApiClient _courseApiClient;

  @override
  void init() {
    super.init();
    _courseApiClient = CourseApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _courseApiClient.getKnow(model.id);
    view.updateState();
  }

  void onLesson() {
    Utils.navigatePage(
        context, LessonView(sub: sub, title: model.title, listKnow: list, idSub: idSub));
  }
}
