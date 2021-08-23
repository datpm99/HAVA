import 'package:hava/models/know_model.dart';
import 'package:hava/src/lib_presenter.dart';
import '../../course_api_client.dart';

class Theory2Presenter extends Presenter {
  Theory2Presenter(BuildContext context, Contract view, this.id) : super(context, view);

  final int id;
  late CourseApiClient _courseApiClient;
  String content = '';
  bool isLoading = true;


  @override
  void init() {
    super.init();
    _courseApiClient = CourseApiClient(context);
  }

  @override
  void loadData() async{
    super.loadData();
    KnowModel model = await _courseApiClient.getTheory(id);
    model.content = unescape.convert(model.content);
    content = model.content;
    isLoading = false;
    view.updateState();
  }
}
