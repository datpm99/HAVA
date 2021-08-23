import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/video_model.dart';
import 'package:hava/screens/guide/guide_view.dart';
import '../item_video_view.dart';
import '../video_api_client.dart';

class PlayVideoPresenter extends Presenter {
  PlayVideoPresenter(BuildContext context, Contract view, this.model)
      : super(context, view);
  final VideoModel model;
  bool isShow = true;

  String get title => model.title;

  String get linkYT => model.contents;

  late VideoApiClient _videoApiClient;
  List<VideoModel> listVideo = [];

  @override
  void init() {
    super.init();
    _videoApiClient = VideoApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    listVideo = await _videoApiClient.getVideo();
    listVideo.removeWhere((element) => element.id == model.id);
    list = listVideo;
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      VideoModel model = list[index];
      return ItemVideoView(margin: 15, model: model, type: 1);
    }
    return super.itemBuild(context, index);
  }

  void onHideView() {
    isShow = false;
    view.updateState();
  }

  void onGuide() {
    Utils.navigatePage(context, const GuideView());
  }
}
